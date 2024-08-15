import { LazyPlugin } from "../../ambient/lazy";

const plugin: LazyPlugin = {
  1: 'kdheepak/lazygit.nvim',
  cmd: [
    "LazyGit",
    "LazyGitConfig",
    "LazyGitCurrentFile",
    "LazyGitFilter",
    "LazyGitFilterCurrentFile",
  ],
  dependencies: [
    "nvim-lua/plenary.nvim"
  ],
  keys: [{
    1: '<leader>lg',
    2: '<cmd>LazyGit<CR>'
  }]
};
export { plugin as default };
