import { LazyPlugin } from "../../ambient/lazy";

const plugin: LazyPlugin = {
  1: 'nvim-neotest/neotest',
  dependencies: [
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter"
  ]
};
export { plugin as default };
