import { LazyPlugin } from "../../ambient/lazy";
import { useExternalModule } from "../helpers/module/useModule";

function useHLChunk() {
  type Module = {
    setup: (this: void, opts: unknown) => void
  };

  return useExternalModule<Module>("hlchunk");
}

const plugin: LazyPlugin = {
  1: 'shellRaining/hlchunk.nvim',
  event: ["BufReadPre", "BufNewFile"],
  config: () => {
    useHLChunk().setup({
      chunk: {
        enable: true
      }
    });
  }
};
export { plugin as default };
