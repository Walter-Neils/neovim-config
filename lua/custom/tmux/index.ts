import { getGlobalConfiguration } from "../../helpers/configuration";
import { useNUI } from "../../plugins/nui";

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

export function initCustomTmux() {
  vim.api.nvim_create_user_command('ChangeTmuxScope', changeTmuxScope, {});
}
