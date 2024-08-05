import { LazyPlugin } from "../../ambient/lazy";

const plugin: LazyPlugin = {
  1: 'windwp/nvim-autopairs',
  event: "InsertEnter",
  config: true
};
export { plugin as default };
