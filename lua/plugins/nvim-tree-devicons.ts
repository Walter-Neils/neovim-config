import { LazyPlugin } from "../../ambient/lazy";

const plugin: LazyPlugin = {
  1: 'nvim-tree/nvim-web-devicons',
  config: function(this: void) {
    let target = "nvim-web-devicons";
    const module = require<{ setup: (this: void) => void }>(target);
    module.setup();
  }
};
export { plugin as default };
