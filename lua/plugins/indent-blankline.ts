import { LazyPlugin } from "../../ambient/lazy";

const plugin: LazyPlugin = {
  1: 'lukas-reineke/indent-blankline.nvim',
  version: "^3",
  config: function(this: void) {
    let target = "ibl";
    const ibl = require<{
      setup: (this: void, opts?: unknown) => void
    }>(target);
    ibl.setup()
  }
};
export { plugin as default };
