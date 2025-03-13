import { LazyPlugin } from "../../ambient/lazy";
import { getGlobalConfiguration } from "../helpers/configuration";
import { useExternalModule } from "../helpers/module/useModule";
import { registerLSPServerAttachCallback } from "./lspconfig";

const config = {
  bind: true,
  always_trigger: true,
  // floating_window: true // Breaks stuff
  max_height: 50,
  move_cursor_key: '<M-p>',
  toggle_key: '<M-x>'
};

const plugin: LazyPlugin = {
  1: "ray-x/lsp_signature.nvim",
  event: "LspAttach",
  config: function(this: void, _: unknown, opts: unknown) {
    const lsp_signature = useExternalModule<{ setup: (this: void, opts: unknown) => void }>("lsp_signature");
    lsp_signature.setup(config);
  }
};
// if (getGlobalConfiguration().packages["lspSignature"]?.enabled ?? false) {
//   registerLSPServerAttachCallback(function(this: void, _client: NvimLspClient, bufnr: number) {
//     useExternalModule<{
//       on_attach: (this: void, config: unknown, bufnr: number) => void;
//     }>("lsp_signature").on_attach(config, bufnr);
//   });
// }
export { plugin as default };
