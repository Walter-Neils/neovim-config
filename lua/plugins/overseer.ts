import { LazyPlugin } from "../../ambient/lazy";
import { useExternalModule } from "../helpers/module/useModule";

function useOverseer() {
  type Module = {
    setup: (this: void, opts?: unknown) => void
  };
  return useExternalModule<Module>("overseer");
}

const plugin: LazyPlugin = {
  1: 'stevearc/overseer.nvim',
  opts: {},
  config: () => {
    useOverseer().setup();
  }
};
export { plugin as default };
