import { LazyPlugin } from "../../ambient/lazy";
import { useExternalModule } from "../helpers/module/useModule";

const plugin: LazyPlugin = {
  1: 'rose-pine/neovim',
  name: 'rose-pine',
  lazy: false,
  priority: 1000,
  config: function(this: void) {
    useExternalModule<{ setup: (this: void, config: unknown) => void }>('rose-pine').setup({
      variant: 'auto'
    });
  }
};
export { plugin as default };
