import { LazyPlugin } from "../../ambient/lazy";

const plugin: LazyPlugin = {
  1: 'altermo/ultimate-autopair.nvim',
  event: ["InsertEnter", "CmdlineEnter"],
  opts: {
    bs: {
      space: 'balance'
    },
    cr: {
      autoclose: true
    },
  }
};
export { plugin as default };
