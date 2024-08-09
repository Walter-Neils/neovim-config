import { LazyPlugin } from "../../ambient/lazy";

const plugin: LazyPlugin = {
  1: 'chentoast/marks.nvim',
  config: function(this: void) {
    let target = "marks";
    require<{ setup: (this: void) => void }>(target).setup();
  }
};
export { plugin as default };
