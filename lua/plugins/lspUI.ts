import { LazyPlugin } from "../../ambient/lazy";

const plugin: LazyPlugin = {
  1: 'jinzhongjia/LspUI.nvim',
  branch: "main",
  event: 'VeryLazy',
  config: function(this: void) {
    let target = "LspUI";
    const lspUI = require<{ setup: (this: void, arg: unknown) => unknown }>(target);
    lspUI.setup({
      inlay_hint: {
        enable: false
      }
    });
  }
};
export { plugin as default };
