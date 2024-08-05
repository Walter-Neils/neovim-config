import { LazyPlugin } from "../../ambient/lazy";

const plugin: LazyPlugin = {
  1: "williamboman/mason.nvim",
  config: () => {
    let target = "mason";
    require<{ setup: (this: void) => void }>(target).setup();
  }
};
export { plugin as default };
