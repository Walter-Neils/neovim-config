import { LazyPlugin } from "../../ambient/lazy";
import { useExternalModule } from "../helpers/module/useModule";

const plugin: LazyPlugin = {
  1: 'catgoose/nvim-colorizer.lua',
  event: "VeryLazy",
  config: () => {
    useExternalModule<{ setup: (this: void) => void }>("colorizer").setup();
  }
};
export { plugin as default };
