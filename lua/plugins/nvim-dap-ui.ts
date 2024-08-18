import { LazyPlugin } from "../../ambient/lazy";
import { useExternalModule } from "../helpers/module/useModule";
import { CONFIGURATION } from "../toggles";

type DapUIModule = {
  setup: (this: void, arg: unknown) => void,
  open: (this: void) => void,
  close: (this: void) => void,
  toggle: (this: void) => void,
  eval: (this: void, expression?: unknown) => void
};

type DapAdapterStructure = {
  type: 'server',
  host: '::1' | string,
  port: number | '${port}',
  executable: {
    command: string,
    args?: string[]
  }
} | {
  type: 'executable',
  command: string,
  name: string
};

type DapConfig = {
  // Where type is a key in dap.adapters
  type: string,
  request: 'launch',
  name: string,
  program: '${file}' | string | ((this: void) => string),
  cwd: '${workspaceFolder}' | string,
  runtimeExecutable?: 'node' | string,
  stopOnEntry?: boolean,
  args?: string[],
  runInTerminal?: boolean
};

type DapModule = {
  listeners: {
    before: {
      attach: {
        [key: string]: (this: void) => void
      },
      launch: {
        [key: string]: (this: void) => void
      },
      event_terminated: {
        [key: string]: (this: void) => void
      },
      event_exited: {
        [key: string]: (this: void) => void
      },
    }
  },
  adapters: {
    [key: string]: DapAdapterStructure
  },
  configurations: {
    [key: string]: DapConfig[]
  }
};

export function getDap(this: void) {
  let target = 'dap';
  const dapui = useExternalModule<DapModule>(target);
  return dapui;
}

export function getDapUI(this: void) {
  let target = 'dapui';
  const dapui = useExternalModule<DapUIModule>(target);
  return dapui;
}

function bindDapUIEvents(this: void) {
  const dap = getDap();
  const dapui = getDapUI();

  dap.listeners.before.attach.dapui_config = function(this: void) { dapui.open(); }
  dap.listeners.before.launch.dapui_config = function(this: void) { dapui.open(); }
  dap.listeners.before.event_terminated.dapui_config = function(this: void) { dapui.close(); }
  dap.listeners.before.event_exited.dapui_config = function(this: void) { dapui.close(); }
}



let cppExePath: string | undefined;
function getCPPTargetExecutable(this: void) {
  if (cppExePath === undefined) {
    cppExePath = vim.fn.input('Path to executable: ', vim.fn.getcwd() + "/", 'file');
    if (!vim.loop.fs_stat(cppExePath)) {
      cppExePath = undefined;
      throw new Error(`File not found`);
    }
  }
  return cppExePath;
}

vim.api.nvim_create_autocmd('DirChanged', {
  callback: function(this: void) {
    cppExePath = undefined;
  }
});

function configureActiveLanguages(this: void) {
  const dap = getDap();
  if (CONFIGURATION.dap.cPlusPlus) {
    const LLDB_PORT = 1828;
    dap.adapters['lldb'] = {
      type: 'server',
      port: LLDB_PORT,
      host: '127.0.0.1',
      executable: {
        command: 'codelldb',
        args: ['--port', LLDB_PORT.toString()]
      }
    }

    for (const language of ['cpp', 'c'] as const) {
      dap.configurations[language] = [{
        name: 'Launch',
        type: 'lldb',
        request: 'launch',
        program: getCPPTargetExecutable,
        cwd: '${workspaceFolder}',
        stopOnEntry: false,
        args: [],
        runInTerminal: true
      }]
    }
  }
  if (CONFIGURATION.dap.nodeJS) {
    dap.adapters['pwa-node'] = {
      type: 'server',
      host: '::1',
      port: 8123,
      executable: {
        command: 'js-debug-adapter'
      }
    };

    for (const language of ['javascript', 'typescript'] as const) {
      dap.configurations[language] = [{
        type: 'pwa-node',
        request: 'launch',
        name: 'Launch file',
        program: '${file}',
        cwd: '${workspaceFolder}',
        runtimeExecutable: 'node'
      }]
    }
  }
}

const plugin: LazyPlugin = {
  1: 'rcarriga/nvim-dap-ui',
  dependencies: ["mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"],
  config: function(this: void) {
    getDapUI().setup({});
    bindDapUIEvents();
    configureActiveLanguages();
  }
};
export { plugin as default };
