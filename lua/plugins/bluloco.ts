import { LazyPlugin } from "../../ambient/lazy";
import { useExternalModule } from "../helpers/module/useModule";

const plugin: LazyPlugin = {
  1: 'uloco/bluloco.nvim',
  lazy: false,
  priority: 1000,
  dependencies: ["rktjmp/lush.nvim"],
  config: () => {
    useExternalModule<{ setup: (this: void, args: unknown) => void }>("bluloco").setup({
      style: 'dark',
      terminal: vim.fn.has("gui_running") == 1,
      guicursor: true
    });
  }
};
export { plugin as default };
