import { LazyPlugin } from "../../ambient/lazy";
import { getGlobalConfiguration } from "../helpers/configuration";
import { useExternalModule } from "../helpers/module/useModule";

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
  runtimeArgs?: string[],
  stopOnEntry?: boolean,
  args?: string[],
  runInTerminal?: boolean
} & {
  [key: string]: unknown | undefined
};
type DapStatus = 'Running' | `Closed session: ${number}` | '';
type DapModule = {
  status: (this: void) => DapStatus,
  run_to_cursor: (this: void) => void,
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

type DapGlobalConfig = {
  lldb: {
    host?: string,
    port: number,
    executable?: string,
    additionalArgs?: string[]
  }
};

function configureActiveLanguages(this: void) {
  const config = getGlobalConfiguration();
  const dapConfig = config.packages["nvimDapUI"]?.config as DapGlobalConfig;
  if (dapConfig === undefined) {
    vim.notify("DAP configuration undefined. Unable to continue setup.", vim.log.levels.ERROR);
    return;
  }
  const dap = getDap();
  if (config.targetEnvironments["c/c++"]?.enabled) {

    const LLDB_PORT = dapConfig.lldb.port;
    dap.adapters['lldb'] = {
      type: 'server',
      port: LLDB_PORT,
      host: dapConfig.lldb.host ?? '127.0.0.1',
      executable: {
        command: dapConfig.lldb.executable ?? 'codelldb',
        args: ['--port', LLDB_PORT.toString(), ...dapConfig.lldb.additionalArgs ?? []]
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
  const possibleTargets = ["nodejs", "javascript", "typescript"];
  if (possibleTargets.some(x => {
    return config.targetEnvironments[x]?.enabled ?? false;
  })) {
    dap.adapters['pwa-node'] = {
      type: 'server',
      host: '::1',
      port: 8123,
      executable: {
        command: 'js-debug-adapter'
      }
    };
    dap.adapters["node2"] = {
      name: 'NodeJS Debug',
      type: 'executable',
      command: 'node-debug2-adapter'
    };

    for (const language of ['javascript', 'typescript'] as const) {
      if (config.targetEnvironments[language]?.enabled) {
        dap.configurations[language] = [{
          type: 'node2',
          request: 'launch',
          name: 'Launch file',
          program: '${file}',
          cwd: '${workspaceFolder}',
          runtimeExecutable: 'node',
          outDir: 'dist',
          args: ["${file}"],
          sourceMap: true,
          skipFiles: ["<node_internals>/**", "node_modules/**"],
          protocol: 'inspector',
          outFiles: ['${workspaceFolder}/dist/*.js']
        }];
      }
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
