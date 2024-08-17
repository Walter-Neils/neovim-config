import { LazyPlugin } from "../../ambient/lazy";
import { useExternalModule } from "../helpers/module/useModule";

function getNoice(this: void) {
  type NoiceType = {
    setup: (this: void, arg: unknown) => void
  };
  const noice = useExternalModule<NoiceType>("noice");
  return noice;
}

const plugin: LazyPlugin = {
  1: 'folke/noice.nvim',
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
      const noice = getNoice();
      noice.setup({})
    }
  }
};
export { plugin as default };
