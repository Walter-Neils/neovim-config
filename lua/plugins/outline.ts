import { LazyPlugin } from "../../ambient/lazy";

const plugin: LazyPlugin = {
  1: 'hedyhli/outline.nvim',
  lazy: true,
  cmd: ['Outline', 'OutlineOpen'],
  keys: [{
    1: '<leader>o',
    2: '<cmd>Outline<CR>',
    desc: 'Toggle outline'
  }],
  opts: {
    symbol_folding: {
      // autofold_depth: false
    },
    preview_window: {
      auto_preview: true,
      live: true
    },
    outline_items: {
      show_symbol_lineno: true
    }
  }
};
export { plugin as default };
