import { LazyPlugin } from "../../ambient/lazy";

const plugin: LazyPlugin = {
  1: 'willothy/flatten.nvim',
  config: true,
  lazy: false,
  priority: 1001,
};
export { plugin as default };
