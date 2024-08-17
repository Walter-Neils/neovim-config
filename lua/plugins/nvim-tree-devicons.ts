import { LazyPlugin } from "../../ambient/lazy";
import { useExternalModule } from "../helpers/module/useModule";

const plugin: LazyPlugin = {
  1: 'nvim-tree/nvim-web-devicons',
  config: function(this: void) {
    const module = useExternalModule<{ setup: (this: void) => void }>("nvim-web-devicons");
    module.setup();
  }
};
export { plugin as default };
