import { LazyPlugin } from "../../ambient/lazy";

const plugin: LazyPlugin = {
  1: 'romgrk/barbar.nvim',
  dependencies: ['lewis6991/gitsigns.nvim', 'nvim-tree/nvim-web-devicons'],
  init: function(this: void) {
    (vim.g as unknown as { barbar_auto_setup: boolean }).barbar_auto_setup = false;
  },
  opts: {
    animation: true,
    insert_at_start: true
  }
};
export { plugin as default };
