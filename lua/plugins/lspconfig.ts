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

type LSPConfig = {
  tsserver: LSPConfigInstanceBase<{}>,
  lua_ls: LSPConfigInstanceBase<{}>
};

function on_attach(this: void, client: LSPClient, bufnr: number) {
  if (CONFIGURATION.lspconfig.useInlayHints) {
    let error: any | undefined;
    try {
      if (client.server_capabilities.inlayHintProvider) {
        if (vim.lsp.buf.inlay_hint === undefined) {
          vim.notify(`Failed to enable inlay hints: neovim builtin inlay_hints unavailable`);
        }
        else {
          vim.lsp.buf.inlay_hint.enable(true, { bufnr });
        }
        return;
      }
    } catch (e: any) { error = e; }
    vim.notify(`Failed to enable LSP hints: ${error}`);
  }
}


function configureLSP(this: void) {
  let target = "lspconfig";
  const lspconfig = require<LSPConfig>(target);
  let capabilities: unknown | undefined;
  if (CONFIGURATION.useCMP) {
    let target = "cmp_nvim_lsp";
    capabilities = require<{ default_capabilities: (this: void) => unknown }>(target).default_capabilities();
  }
  lspconfig.tsserver.setup({
    capabilities,
    on_attach
  });
  lspconfig.lua_ls.setup({
    capabilities,
    on_attach
  });
  vim.diagnostic.config({
    update_in_insert: true,
    virtual_text: !CONFIGURATION.useLSPLines
  });
}
export { plugin as default };
