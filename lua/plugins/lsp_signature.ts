import { LazyPlugin } from "../../ambient/lazy";
import { useExternalModule } from "../helpers/module/useModule";

const plugin: LazyPlugin = {
  1: "ray-x/lsp_signature.nvim",
  event: "VeryLazy",
  config: function(this: void, _: unknown, opts: unknown) {
    const lsp_signature = useExternalModule<{ setup: (this: void, opts: unknown) => void }>("lsp_signature");
    lsp_signature.setup({
      always_trigger: true
    });
  }
};
export { plugin as default };
