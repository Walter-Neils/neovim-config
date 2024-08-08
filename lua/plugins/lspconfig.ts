import { LazyPlugin } from "../../ambient/lazy";
import { CONFIGURATION } from "../toggles";

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
};

export type LSPConfig = {
  util: {
    available_servers: (this: void) => (keyof LSPConfigServers)[]
  }
} & LSPConfigServers;

function on_attach(this: void, client: LSPClient, bufnr: number) {
  if (CONFIGURATION.lspconfig.useInlayHints) {
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

if (CONFIGURATION.lspconfig.useInlayHints) {
  vim.api.nvim_create_autocmd('InsertEnter', {
    callback: () => {
      if (CONFIGURATION.lspconfig.inlayHints.displayMode === 'only-in-normal-mode') {
        vim.lsp.inlay_hint.enable(false);
      }
    }
  });

  vim.api.nvim_create_autocmd('InsertLeave', {
    callback: () => {
      if (CONFIGURATION.lspconfig.inlayHints.displayMode === 'only-in-normal-mode') {
        vim.lsp.inlay_hint.enable(true);
      }
    }
  });
}


export function getLSPConfig(this: void) {
  let target = "lspconfig";
  const lspconfig = require<LSPConfig>(target);
  return lspconfig;
}

function configureLSP(this: void) {
  const lspconfig = getLSPConfig();
  let capabilities: unknown | undefined;
  if (CONFIGURATION.useCMP) {
    let target = "cmp_nvim_lsp";
    capabilities = require<{ default_capabilities: (this: void) => unknown }>(target).default_capabilities();
  }
  const lsptargets = ['tsserver', 'lua_ls'] as const;
  for (const target of lsptargets) {
    lspconfig[target].setup({
      capabilities,
      on_attach
    });
  }
  vim.diagnostic.config({
    update_in_insert: true,
    virtual_text: !CONFIGURATION.useLSPLines
  });
}
export { plugin as default };
