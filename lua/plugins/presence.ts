import { LazyPlugin } from "../../ambient/lazy";
import { useExternalModule } from "../helpers/module/useModule";

function usePresence() {
  return useExternalModule<{
    setup: (this: void, opts: unknown) => void
  }>("presence");
}

const plugin: LazyPlugin = {
  1: 'andweeb/presence.nvim',
  config: () => {
    usePresence().setup({

    });
  }
};
export { plugin as default };
