import { LazyPlugin } from "../../ambient/lazy";
import { useExternalModule } from "../helpers/module/useModule";

const plugin: LazyPlugin = {
  1: 'rmagatti/goto-preview',
  event: 'BufEnter',
  opts: {
    default_mappings: true
  },
  config: true
};
export { plugin as default };
