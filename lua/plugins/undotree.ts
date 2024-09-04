import type { LazyPlugin } from "../../ambient/lazy.d.ts";
import { useExternalModule } from "../helpers/module/useModule";

type UndoTreeModule = {
  setup: (this: void, opts?: unknown) => void,
  toggle: (this: void) => void,
  open: (this: void) => void,
  close: (this: void) => void
};

function getUndoTree() {
  return useExternalModule('undotree') as UndoTreeModule;
}

const plugin: LazyPlugin = {
  1: "jiaoshijie/undotree",
  config: () => {
    getUndoTree().setup();

    // Create commands
    vim.api.nvim_create_user_command('UndoTreeToggle', () => {
      getUndoTree().toggle();
    }, {});
    vim.api.nvim_create_user_command('UndoTreeOpen', () => {
      getUndoTree().open();
    }, {});
    vim.api.nvim_create_user_command('UndoTreeClose', () => {
      getUndoTree().close();
    }, {});
  },
  dependencies: ["nvim-lua/plenary.nvim"],
};


export { plugin as default };
