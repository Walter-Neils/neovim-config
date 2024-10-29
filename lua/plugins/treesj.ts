import { LazyPlugin } from "../../ambient/lazy";
import { applyKeyMapping } from "../helpers/keymap";
import { useExternalModule } from "../helpers/module/useModule";

function getTreesj() {
  type TreesjModule = {
    setup: (this: void, config?: unknown) => void,
    toggle: (this: void) => void
  };
  return useExternalModule<TreesjModule>("treesj");
}

const plugin: LazyPlugin = {
  1: 'Wansmer/treesj',
  keys: ['<space>j'],
  dependencies: ['nvim-treesitter/nvim-treesitter'],
  config: () => {
    applyKeyMapping({
      mode: 'n',
      inputStroke: '<leader>j',
      action: () => {
        getTreesj().toggle();
      },
      options: {

      }
    });
    return getTreesj().setup({
      use_default_keymaps: false,
      max_join_length: 4096
    });
  }
};
export { plugin as default };
