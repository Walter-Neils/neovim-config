import { LazyPlugin } from "../../ambient/lazy";
import { useExternalModule } from "../helpers/module/useModule";

const plugin: LazyPlugin = {
  1: 'dnlhc/glance.nvim',
  config: function(this: void) {
    useExternalModule<{ setup: (this: void, arg: unknown) => void }>("glance").setup({});
  }
};
export { plugin as default };
