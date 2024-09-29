import { LazyPlugin } from "../../ambient/lazy";
import { useExternalModule } from "../helpers/module/useModule";
import { getLSPConfig, registerLSPConfigurationHook } from "./lspconfig";

const plugin: LazyPlugin = {
  1: 'kevinhwang91/nvim-ufo',
  dependencies: ['kevinhwang91/promise-async'],
  event: 'VeryLazy',
  config: function(this: void) {
    vim.o.foldcolumn = '0';
    vim.o.foldlevel = 99;
    vim.o.foldlevelstart = 99;
    vim.o.foldenable = true;

    const capabilities = vim.lsp.protocol.make_client_capabilities();
    capabilities.textDocument.foldingRange = {
      dynamicRegistration: false,
      lineFoldingOnly: true
    };
    registerLSPConfigurationHook((key, config) => {
      config.capabilities.textDocument.foldingRange = {
        dynamicRegistration: false,
        lineFoldingOnly: true
      };
    });
    useExternalModule<{ setup: (this: void, arg?: unknown) => void }>("ufo").setup({
      // TODO: Setup fold_virt_text_handler
    });
  }
};
export { plugin as default };
