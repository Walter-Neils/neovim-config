import { LazyPlugin } from "../../ambient/lazy";

const plugin: LazyPlugin = {
  1: 'nvim-telescope/telescope.nvim',
  dependencies: ['nvim-lua/plenary.nvim']
};
export { plugin as default };
