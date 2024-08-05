import { LazyPlugin } from "../../ambient/lazy";
import { CONFIGURATION } from "../toggles";

const plugin: LazyPlugin = {
  1: 'neovim/nvim-lspconfig',
  config: configureLSP
};
type LSPClient = unknown;
type NeovimLSPCapabilities = unknown;
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


function configureLSP(this: void) {
  let target = "lspconfig";
  const lspconfig = require<LSPConfig>(target);
  let capabilities: unknown | undefined;
  if (CONFIGURATION.useCMP) {
    let target = "cmp_nvim_lsp";
    capabilities = require<{ default_capabilities: (this: void) => unknown }>(target).default_capabilities();
  }
  lspconfig.tsserver.setup({
    capabilities
  });
  lspconfig.lua_ls.setup({
    capabilities
  });
  vim.diagnostic.config({
    update_in_insert: true,
    virtual_text: !CONFIGURATION.useLSPLines
  });
}
export { plugin as default };
