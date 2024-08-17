import { LazyPlugin } from "../../ambient/lazy";
import { useExternalModule } from "../helpers/module/useModule";

const plugin: LazyPlugin = {
  1: "williamboman/mason.nvim",
  config: () => {
    useExternalModule<{ setup: (this: void) => void }>("mason").setup();
  }
};
export { plugin as default };
