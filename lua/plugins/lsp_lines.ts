import { LazyPlugin } from "../../ambient/lazy";
import { useExternalModule } from "../helpers/module/useModule";

const plugin: LazyPlugin = {
  1: 'ErichDonGubler/lsp_lines.nvim',
  event: "VimEnter",
  config: function(this: void) {
    useExternalModule<{ setup: (this: void, arg?: unknown) => void }>("lsp_lines").setup();
  }
};
export { plugin as default };
