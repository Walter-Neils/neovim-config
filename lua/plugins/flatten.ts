import { LazyPlugin } from "../../ambient/lazy";
import { useExternalModule } from "../helpers/module/useModule";

const plugin: LazyPlugin = {
  1: 'willothy/flatten.nvim',
  config: true,
  lazy: false,
  priority: 1001,
};
export { plugin as default };
