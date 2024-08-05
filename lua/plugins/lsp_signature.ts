import { LazyPlugin } from "../../ambient/lazy";

const plugin: LazyPlugin = {
  1: "ray-x/lsp_signature.nvim",
  event: "VeryLazy",
  opts: {},
  config: function(this: void, _: unknown, opts: unknown) {
    let target = "lsp_signature";
    const lsp_signature = require<{ setup: (this: void, opts: unknown) => void }>(target);
    lsp_signature.setup(opts);
  }
};
export { plugin as default };
