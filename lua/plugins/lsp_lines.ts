import { LazyPlugin } from "../../ambient/lazy";

const plugin: LazyPlugin = {
  1: 'ErichDonGubler/lsp_lines.nvim',
  event: "VimEnter",
  config: function(this: void) {
    let target = "lsp_lines";
    require<{ setup: (this: void, arg?: unknown) => void }>(target).setup();
  }
};
export { plugin as default };
