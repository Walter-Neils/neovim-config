import { LazyPlugin } from "../../ambient/lazy";
import { useExternalModule } from "../helpers/module/useModule";

const plugin: LazyPlugin = {
  event: 'VeryLazy',
  cmd: ['Octo'],
  1: 'pwntester/octo.nvim',
  dependencies: ['nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim', 'nvim-tree/nvim-web-devicons'],
  config: function(this: void) {
    useExternalModule<{ setup: (this: void) => void }>('octo').setup();
    vim.treesitter.language.register('markdown', 'octo');
  }
};
export { plugin as default };
