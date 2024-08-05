import { LazyPlugin } from "../../ambient/lazy";

const plugin: LazyPlugin = {
  1: 'nvim-lualine/lualine.nvim',
  dependencies: ['nvim-tree/nvim-web-devicons'],
  config: function(this: void) {
    let target = "lualine";
    const module = require<{
      setup: (this: void, arg: unknown) => void
    }>(target);
    module.setup({
      options: {
        theme: 'material'
      }
    })
  }
};
export { plugin as default };
