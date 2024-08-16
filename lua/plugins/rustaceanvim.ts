import { LazyPlugin } from "../../ambient/lazy";

export function getRustaceonVimExtendedVIMApi(this: void) {
  return vim as VimAPI & {
    g: {
      rustaceanvim: {
        tools?: {
          hover_actions?: {
            auto_focus?: boolean,
            replace_builtin_hover?: boolean,
          }
        },
        server?: {
        }
      }
    }
  };
}

const plugin: LazyPlugin = {
  1: 'mrcjkb/rustaceanvim',
  version: '^5',
  ft: ['rust'],
  dependencies: [
    "nvim-lua/plenary.nvim",
    "mfussenegger/nvim-dap",
  ],
  config: function(this: void) {
    const vim = getRustaceonVimExtendedVIMApi();
    vim.g.rustaceanvim = {
      tools: {
        hover_actions: {
          auto_focus: false,
          replace_builtin_hover: false
        },
      }
    };
  }
};
export { plugin as default };
