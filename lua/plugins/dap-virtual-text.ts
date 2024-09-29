import { LazyPlugin } from "../../ambient/lazy";
import { useExternalModule } from "../helpers/module/useModule";

function useNvimDapVirtualText() {
  type DVTModule = {
    setup: (this: void, opts?: unknown) => void
  };

  return useExternalModule<DVTModule>("nvim-dap-virtual-text");
}

const plugin: LazyPlugin = {
  1: 'theHamsta/nvim-dap-virtual-text',
  event: "LspAttach",
  config: () => {
    useNvimDapVirtualText().setup();
  }
};
export { plugin as default };
