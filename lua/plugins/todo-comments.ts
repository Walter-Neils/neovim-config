import { LazyPlugin } from "../../ambient/lazy";

const plugin: LazyPlugin = {
  1: 'folke/todo-comments.nvim',
  dependencies: ["nvim-lua/plenary.nvim"],
  opts: {}
};
export { plugin as default };
