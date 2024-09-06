import { LazyPlugin } from "../../ambient/lazy";
import { keyMappingExists } from "../helpers/keymap";
import { useExternalModule } from "../helpers/module/useModule";

function getLeap(this: void) {
  return useExternalModule<{
    create_default_mappings: (this: void) => void
  }>("leap");
}

const plugin: LazyPlugin = {
  1: 'ggandor/leap.nvim',
  event: "VeryLazy",
  config: function(this: void) {
    if (keyMappingExists('n', 'S')) {
      vim.notify(`Deleting conflicting mapping n::S`, vim.log.levels.WARN);
      vim.keymap.del('n', 'S');
    }
    if (keyMappingExists('n', 's')) {
      vim.notify(`Deleting conflicting mapping n::s`, vim.log.levels.WARN);
      vim.keymap.del('n', 's');
    }
    getLeap().create_default_mappings();
  }
};
export { plugin as default };
