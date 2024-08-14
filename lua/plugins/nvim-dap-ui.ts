import { LazyPlugin } from "../../ambient/lazy";
import { CONFIGURATION } from "../toggles";

type DapUIModule = {
  setup: (this: void, arg: unknown) => void,
  open: (this: void) => void,
  close: (this: void) => void,
  toggle: (this: void) => void
};

type DapAdapterStructure = {
  type: 'server',
  host: '::1' | string,
  port: number,
  executable: {
    command: string
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
  program: '${file}' | string,
  cwd: '${workspaceFolder}' | string,
  runtimeExecutable: 'node' | string
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
  const dapui = require<DapModule>(target);
  return dapui;
}

export function getDapUI(this: void) {
  let target = 'dapui';
  const dapui = require<DapUIModule>(target);
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

function configureActiveLanguages(this: void) {
  const dap = getDap();
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
