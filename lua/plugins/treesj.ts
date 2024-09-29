import { LazyPlugin } from "../../ambient/lazy";
import { useExternalModule } from "../helpers/module/useModule";

function getTreesj() {
  type TreesjModule = {
    setup: (this: void, config?: unknown) => void
  };
  return useExternalModule<TreesjModule>("treesj");
}

const plugin: LazyPlugin = {
  1: 'Wansmer/treesj',
  keys: ['<space>j', '<space>s'],
  dependencies: ['nvim-treesitter/nvim-treesitter'],
  config: () => {
    getTreesj().setup();
  }
};
export { plugin as default };
