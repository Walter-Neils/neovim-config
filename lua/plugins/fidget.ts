import { LazyPlugin } from "../../ambient/lazy";
import { useExternalModule } from "../helpers/module/useModule";

function useFidgetPlugin() {
  type FidgetModule = {
    setup: (this: void) => void
  }

  return useExternalModule<FidgetModule>("fidget");
}

const plugin: LazyPlugin = {
  1: 'j-hui/fidget.nvim',
  event: 'VeryLazy',
  opts: {
    
  }
};
export { plugin as default };
