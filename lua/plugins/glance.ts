import { LazyPlugin } from "../../ambient/lazy";

const plugin: LazyPlugin = {
  1: 'dnlhc/glance.nvim',
  config: function(this: void) {
    const target = 'glance';
    require<{ setup: (this: void, arg: unknown) => void }>(target).setup({});
  }
};
export { plugin as default };
