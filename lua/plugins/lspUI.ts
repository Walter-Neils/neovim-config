import { LazyPlugin } from "../../ambient/lazy";
import { useExternalModule } from "../helpers/module/useModule";

const plugin: LazyPlugin = {
  1: 'jinzhongjia/LspUI.nvim',
  branch: "main",
  event: 'VeryLazy',
  config: function(this: void) {
    const lspUI = useExternalModule<{ setup: (this: void, arg: unknown) => unknown }>("LspUI");
    lspUI.setup({
      inlay_hint: {
        enable: false
      }
    });
  }
};
export { plugin as default };
