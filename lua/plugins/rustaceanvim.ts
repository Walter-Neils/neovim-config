import { LazyPlugin } from "../../ambient/lazy";

const plugin: LazyPlugin = {
  1: 'mrcjkb/rustaceanvim',
  version: '^3',
  ft: ['rust'],
  dependencies: [
    "nvim-lua/plenary.nvim",
    "mfussenegger/nvim-dap",
  ],
  config: function(this: void) {
    (vim.g as any).rustaceanvim = {
      tools: {
        hover_actions: {
          auto_focus: true
        }
      },
      server: {
        on_attach: function(this: void, client: unknown, bufnr: number) {
          vim.notify(`rustaceanvim attached`);
        }
      }
    }
  }
};
export { plugin as default };
