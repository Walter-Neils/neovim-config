import { LazyPlugin } from "../../ambient/lazy";

const plugin: LazyPlugin = {
  1: 'OXY2DEV/markview.nvim',
  lazy: false,
  dependencies: ["nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons"]
};
export { plugin as default };
