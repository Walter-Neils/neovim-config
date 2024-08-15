import { LazyPlugin } from "../../ambient/lazy";

function getNoice(this: void) {
  type NoiceType = {
    setup: (this: void, arg: unknown) => void
  };
  let target = "noice";
  const noice = require<NoiceType>(target);
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
    const noice = getNoice();
    noice.setup({})
  }
};
export { plugin as default };
