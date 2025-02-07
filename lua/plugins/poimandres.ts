import { LazyPlugin } from "../../ambient/lazy";
import { useExternalModule } from "../helpers/module/useModule";

const plugin: LazyPlugin = {
  1: 'olivercederborg/poimandres.nvim',
  lazy: false,
  priority: 1000,
  config: () => {
    useExternalModule<{ setup: (this: void, args: unknown) => void }>("poimandres").setup({});
  }
};
export { plugin as default };
