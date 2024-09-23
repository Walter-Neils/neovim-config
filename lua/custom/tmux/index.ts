import { getGlobalConfiguration } from "../../helpers/configuration";
import { useNUI } from "../../plugins/nui";
import { fs } from "../../shims/fs";

function setTmuxScope(this: void, isolationScope: string) {
  const globalConfig = getGlobalConfiguration();
  if (isolationScope === 'global') {
    vim.o.shell = 'tmux';
    globalConfig.shell.isolationScope = 'global';
  }
  else if (isolationScope === 'neovim-shared') {
    vim.o.shell = 'tmux -L neovim';
    globalConfig.shell.isolationScope = 'neovim-shared';
  }
  else if (isolationScope === 'per-instance') {
    vim.o.shell = `tmux -L neovim-${vim.fn.getpid()}`
    globalConfig.shell.isolationScope = 'isolated';
  }
  else {
    throw new Error(`Invalid scope ${isolationScope}`);
  }
}

function changeTmuxScope() {
  const NUI = useNUI();

  const menu = NUI.Menu({
    position: '50%',
    size: {
      width: 33,
      height: 3
    },
    border: {
      style: 'single',
      text: {
        top: 'Change TMUX scope'
      }
    }
  }, {
    lines: [NUI.Menu.item("Global", { target: 'global' }), NUI.Menu.item("Shared between neovim instances", { target: 'neovim-shared' }), NUI.Menu.item("Isolated", { target: 'per-instance' })],
    on_submit: _item => {
      const item: typeof _item & { target: string } = _item as unknown as any;
      setTmuxScope(item.target);
    }
  });

  menu.mount();
}

function pruneDeadTmuxSockets(this: void) {
  const SOCKET_DIR = vim.env["TMUX_TMPDIR"] ?? "/tmp";
  const userID = vim.loop.getuid();
  // Sending SIGUSR1 to a tmux instance causes it to recreate it's socket if it's missing
  // So we delete all sockets, and then make tmux recreate them if that specific instance is still alive
  const socketsDirectory = `${SOCKET_DIR}/tmux-${userID}`;
  vim.fn.system(['bash', '-c', `rm -f ${socketsDirectory}/*`]);
  vim.fn.system(['pkill', '-USR1', 'tmux']);
}

export function selectCustomTmuxScope(this: void) {
  if (getGlobalConfiguration().packages.floatTerm?.enabled) {
    try {
      vim.cmd("FloatermKill!");
    } catch { }
  }
  pruneDeadTmuxSockets();
  const SOCKET_DIR = vim.env["TMUX_TMPDIR"] ?? "/tmp";
  const userID = vim.loop.getuid();
  const socketsDirectory = `${SOCKET_DIR}/tmux-${userID}`;
  const entries = fs.readdirSync(socketsDirectory);
  vim.ui.select(entries, {
    prompt: 'Select a session',
    format_item: item => {
      const label = item.path.replace(socketsDirectory + "/", "");
      if (item.path.includes(vim.fn.getpid().toString())) {
        return `${label} -- Instance Pair`;
      }
      else {
        return label;
      }
    }
  }, choice => {
    if (choice === undefined) return;
    const id = choice.path.replace(socketsDirectory + "/", "");
    vim.g.terminal_emulator = `tmux -L ${id}`;
    if (getGlobalConfiguration().packages.floatTerm?.enabled) {
      try {
        vim.cmd("FloatermKill!");
        (vim.g as unknown as { floaterm_title: string }).floaterm_title = `tmux ${id}`;
      } catch { }
    }
    console.log(vim.g.terminal_emulator);
  });
}

export function isRunningInsideTmux() {
  if (os.getenv("TERM")?.includes("tmux")) {
    return true;
  }
  else {
    return false;
  }
}

export function initCustomTmux() {
  const shellConfig = getGlobalConfiguration().shell;
  if (shellConfig.target === 'tmux') {
    const term = os.getenv("TERM") ?? '__term_value_not_supplied';
    if (!term.includes('tmux')) {
      vim.g.terminal_emulator = 'tmux';
      const isolationScope = shellConfig.isolationScope;
      if (isolationScope === 'global') {
        vim.o.shell = 'tmux';
      }
      else if (isolationScope === 'neovim-shared') {
        vim.o.shell = 'tmux -L neovim';
      }
      else if (isolationScope === 'isolated') {
        vim.o.shell = `tmux -L neovim-${vim.fn.getpid()}`
      }
      else {
        vim.notify(`Invalid option '${isolationScope}' for tmux isolation scope.`);
        vim.o.shell = 'tmux';
      }
    } else {
      // Running `tmux` as the terminal provider would cause nesting, which is NOT desirable. 
    }
  }
  vim.api.nvim_create_user_command('ChangeTmuxScope', changeTmuxScope, {});
  vim.api.nvim_create_user_command('SelectTmuxScope', selectCustomTmuxScope, {});
  vim.api.nvim_create_user_command('PruneTmuxInstanceSockets', pruneDeadTmuxSockets, {});

}
