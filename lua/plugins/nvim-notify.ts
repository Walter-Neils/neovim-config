import { LazyPlugin } from "../../ambient/lazy";
import { useExternalModule } from "../helpers/module/useModule";

function getNvimNotify(this: void) {
  type NoiceType = {
    setup: (this: void, arg: unknown) => void
  };
  const noice = useExternalModule<NoiceType>("notify");
  return noice;
}

const plugin: LazyPlugin = {
  1: 'rcarriga/nvim-notify',
  event: "VeryLazy",
  dependencies: [
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify"
  ],
  config: function(this: void) {
    if ((vim.g as unknown as { started_by_firenvim: boolean }).started_by_firenvim) {
      // Don't run fancy GUI in firenvim
    }
    else {
      const notify = getNvimNotify();
      notify.setup({})
      vim.notify = notify as unknown as (typeof vim)["notify"];
    }
  }
};
export { plugin as default };
