import { LazyPlugin } from "../../ambient/lazy";
import { getGlobalConfiguration } from "../helpers/configuration";
import { useExternalModule } from "../helpers/module/useModule";
import { getNavic } from "./navic";

const plugin: LazyPlugin = {
  1: "neovim/nvim-lspconfig",
  config: configureLSP,
};
type LSPClient = NvimLspClient;
type NeovimLSPCapabilities = any;
type LSPConfigInstanceBase<Extension> = {
  setup: (
    this: void,
    config: {
      on_attach?: (this: void, client: LSPClient, bufnr: number) => void;
      capabilities?: NeovimLSPCapabilities;
    } & Extension,
  ) => void;
};

type LSPConfigServers = {
  tsserver: LSPConfigInstanceBase<{}>;
  lua_ls: LSPConfigInstanceBase<{}>;
} & {
  [key: string]: LSPConfigInstanceBase<{}>;
};

export type LSPConfig = {
  util: {
    available_servers: (this: void) => (keyof LSPConfigServers)[];
    root_pattern: (this: void, ...patterns: string[]) => unknown;
  };
} & LSPConfigServers;

type GlobalConfigLSPConfig = {
  inlayHints: {
    enabled: true;
    displayMode: "only-in-normal-mode";
  };
};

function getConfig() {
  const config = getGlobalConfiguration();
  const lspConfigRoot = config.packages["lspconfig"]!;
  const lspConfig: GlobalConfigLSPConfig = lspConfigRoot
    .config! as GlobalConfigLSPConfig;
  return lspConfig;
}

type LSPAttachCallback = (this: void, client: LSPClient, bufnr: number) => void;
type LSPConfigurationMutator = (this: void, lspKey: string, configuration: any) => void;

const attachCallbacks: LSPAttachCallback[] = [];
const preHooks: LSPConfigurationMutator[] = [];

export function registerLSPServerAttachCallback(this: void, callback: LSPAttachCallback) {
  attachCallbacks.push(callback);
  configureLSP();
}

export function registerLSPConfigurationHook(this: void, hook: LSPConfigurationMutator) {
  preHooks.push(hook);
  configureLSP();
}

function on_attach(this: void, client: LSPClient, bufnr: number) {
  const lspConfig = getConfig();
  // TODO: Move plugin-specific logic to an attach hook
  {
    const navic = getNavic();
    if (navic !== undefined) {
      if (client.server_capabilities.documentSymbolProvider) {
        navic.attach(client, bufnr);
      }
      else {
        // Navic isn't supported
      }
    }
    else {
      // Navic isn't installed
    }
  }
  if (lspConfig.inlayHints.enabled) {
    let error: any | undefined;
    try {
      if (client.server_capabilities.inlayHintProvider) {
        if (vim.lsp.inlay_hint === undefined) {
          vim.notify(
            `Failed to enable inlay hints: neovim builtin inlay_hints unavailable`,
          );
        } else {
          vim.lsp.inlay_hint.enable(true, { bufnr });
        }
        return;
      } else {
        vim.notify("Server does not support inlay hints");
      }
    } catch (e: any) {
      error = e;
    }
    vim.notify(`Failed to enable LSP hints: ${error}`);
  }

  for (const callback of attachCallbacks) {
    callback(client, bufnr);
  }
}

{
  const lspConfig = getConfig();
  if (lspConfig.inlayHints.enabled) {
    vim.api.nvim_create_autocmd("InsertEnter", {
      callback: () => {
        if (lspConfig.inlayHints.displayMode === "only-in-normal-mode") {
          vim.lsp.inlay_hint.enable(false);
        }
      },
    });

    vim.api.nvim_create_autocmd("InsertLeave", {
      callback: () => {
        if (lspConfig.inlayHints.displayMode === "only-in-normal-mode") {
          vim.lsp.inlay_hint.enable(true);
        }
      },
    });
  }
}

export function getLSPConfig(this: void) {
  const lspconfig = useExternalModule<LSPConfig>("lspconfig");
  return lspconfig;
}

function getPluginConfig() {
  const config = getGlobalConfiguration();
  type Config = {};
  return config.packages["lspconfig"] as typeof config.packages["lspconfig"] & {
    config: Config;
  };
}

function environmentKeyToConfig(env: string) {
  const configs: {
    key: string;
    lspKey: string;
    additionalOptions?: unknown;
  }[] = [{
    key: "typescript",
    lspKey: "tsserver",
    additionalOptions: {
      single_file_support: false,
      root_dir: getLSPConfig().util.root_pattern("package.json"),
    },
  }, {
    key: "deno",
    lspKey: "denols",
    additionalOptions: {
      root_dir: getLSPConfig().util.root_pattern("deno.json", "deno.jsonc"),
    },
  }, {
    key: "c/c++",
    lspKey: "clangd",
  }, {
    key: "markdown",
    lspKey: "marksman",
  }, {
    key: 'lua',
    lspKey: 'lua_ls'
  }];

  return configs.find((x) => x.key === env);
}

vim.api.nvim_create_autocmd("LspAttach", {
  callback: (_args) => {
    type ArgsType = {
      buf: number;
      data: {
        client_id: string;
      };
    };
    const args = _args as ArgsType;
  },
});

function configureLSP(this: void) {
  const lspconfig = getLSPConfig();

  const targetEnvironments = getGlobalConfiguration().targetEnvironments;
  for (const targetEnvKey in targetEnvironments) {
    if (!targetEnvironments[targetEnvKey]?.enabled) {
      continue;
    }
    const config = environmentKeyToConfig(targetEnvKey);
    if (config === undefined) {
      vim.notify(
        `Failed to locate configuration for environment ${targetEnvKey}`,
        vim.log.levels.WARN,
      );
    } else {
      let capabilities: unknown | undefined;
      if (getGlobalConfiguration().packages["cmp"]?.enabled) {
        capabilities = useExternalModule<
          { default_capabilities: (this: void) => unknown }
        >("cmp_nvim_lsp").default_capabilities();
      }
      const setupConfig = {
        ...config.additionalOptions ?? {},
        capabilities: capabilities,
        on_attach: on_attach,
      };

      for (const preHook of preHooks) {
        preHook(config.lspKey, setupConfig);
      }

      lspconfig[config.lspKey].setup(setupConfig);
    }
  }
  vim.diagnostic.config({
    update_in_insert: true,
    virtual_text:
      !(getGlobalConfiguration().packages["lspLines"]?.enabled ?? false),
  });
}
export { plugin as default };
