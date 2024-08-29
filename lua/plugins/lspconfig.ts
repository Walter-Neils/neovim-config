import { LazyPlugin } from "../../ambient/lazy";
import { getGlobalConfiguration } from "../helpers/configuration";
import { useExternalModule } from "../helpers/module/useModule";

const plugin: LazyPlugin = {
  1: 'neovim/nvim-lspconfig',
  config: configureLSP
};
type LSPClient = any;
type NeovimLSPCapabilities = any;
type LSPConfigInstanceBase<Extension> = {
  setup: (this: void, config: {
    on_attach?: (this: void, client: LSPClient, bufnr: number) => void,
    capabilities?: NeovimLSPCapabilities
  } & Extension) => void
};

type LSPConfigServers = {
  tsserver: LSPConfigInstanceBase<{}>,
  lua_ls: LSPConfigInstanceBase<{}>
} & {
  [key: string]: LSPConfigInstanceBase<{}>
};

export type LSPConfig = {
  util: {
    available_servers: (this: void) => (keyof LSPConfigServers)[]
  }
} & LSPConfigServers;

type GlobalConfigLSPConfig = {
  inlayHints: {
    enabled: true,
    displayMode: 'only-in-normal-mode'
  }
};

function getConfig() {
  const config = getGlobalConfiguration();
  const lspConfigRoot = config.packages["lspconfig"]!;
  const lspConfig: GlobalConfigLSPConfig = lspConfigRoot.config! as GlobalConfigLSPConfig;
  return lspConfig;
}

function on_attach(this: void, client: LSPClient, bufnr: number) {
  const lspConfig = getConfig();
  if (lspConfig.inlayHints.enabled) {
    let error: any | undefined;
    try {
      if (client.server_capabilities.inlayHintProvider) {
        if (vim.lsp.inlay_hint === undefined) {
          vim.notify(`Failed to enable inlay hints: neovim builtin inlay_hints unavailable`);
        }
        else {
          vim.lsp.inlay_hint.enable(true, { bufnr });
        }
        return;
      }
      else {
        vim.notify("Server does not support inlay hints");
      }
    } catch (e: any) { error = e; }
    vim.notify(`Failed to enable LSP hints: ${error}`);
  }
}

{
  const lspConfig = getConfig();
  if (lspConfig.inlayHints.enabled) {
    vim.api.nvim_create_autocmd('InsertEnter', {
      callback: () => {
        if (lspConfig.inlayHints.displayMode === 'only-in-normal-mode') {
          vim.lsp.inlay_hint.enable(false);
        }
      }
    });

    vim.api.nvim_create_autocmd('InsertLeave', {
      callback: () => {
        if (lspConfig.inlayHints.displayMode === 'only-in-normal-mode') {
          vim.lsp.inlay_hint.enable(true);
        }
      }
    });
  }
}


export function getLSPConfig(this: void) {
  const lspconfig = useExternalModule<LSPConfig>("lspconfig");
  return lspconfig;
}

function getPluginConfig() {
  const config = getGlobalConfiguration();
  type Config = {

  };
  return config.packages["lspconfig"] as typeof config.packages["lspconfig"] & {
    config: Config
  };
}

function environmentKeyToConfig(env: string) {
  const configs = [{
    key: 'typescript',
    lspKey: 'tsserver'
  }, {
    key: 'c/c++',
    lspKey: 'clangd'
  }, {
    key: 'markdown',
    lspKey: 'marksman'
  }];

  return configs.find(x => x.key === env);
}

function configureLSP(this: void) {
  const lspconfig = getLSPConfig();
  const config = getPluginConfig();
  let capabilities: unknown | undefined;
  if (getGlobalConfiguration().packages["cmp"]?.enabled) {
    capabilities = useExternalModule<{ default_capabilities: (this: void) => unknown }>("cmp_nvim_lsp").default_capabilities();
  }
  const targetEnvironments = getGlobalConfiguration().targetEnvironments;
  for (const targetEnvKey in targetEnvironments) {
    const target = targetEnvironments[targetEnvKey];
    const config = environmentKeyToConfig(targetEnvKey);
    if (config === undefined) {
      vim.notify(`Failed to locate configuration for environment ${targetEnvKey}`, vim.log.levels.WARN);
    }
    else {
      lspconfig[config.lspKey].setup({
        capabilities,
        on_attach
      });
    }
  }
  vim.diagnostic.config({
    update_in_insert: true,
    virtual_text: !(getGlobalConfiguration().packages["lspLines"]?.enabled ?? false)
  });
}
export { plugin as default };
