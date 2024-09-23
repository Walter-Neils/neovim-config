import { LazyPlugin } from "../../ambient/lazy";
import { useExternalModule } from "../helpers/module/useModule";

const plugin: LazyPlugin = {
  1: 'HiPhish/rainbow-delimiters.nvim',
  event: "VeryLazy",
  config: () => {
    type RainDelimModule = {
      setup: (this: void, opts: unknown) => void
    };
    useExternalModule<RainDelimModule>('rainbow-delimiters.setup').setup({});
  }
};
export { plugin as default };
