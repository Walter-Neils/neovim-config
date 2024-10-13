import { LazyPlugin } from "../../ambient/lazy";
import { useExternalModule } from "../helpers/module/useModule";

const plugin: LazyPlugin = {
  1: 'NStefan002/screenkey.nvim',
  lazy: false,
  version: '*'
};
export { plugin as default };
