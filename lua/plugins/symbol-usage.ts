import { LazyPlugin } from "../../ambient/lazy";
import { useExternalModule } from "../helpers/module/useModule";

const plugin: LazyPlugin = {
  1: 'Wansmer/symbol-usage.nvim',
  event: 'LspAttach',
  config: function(this: void) {
    useExternalModule<{ setup: (this: void) => void }>("symbol-usage").setup();
  }
};
export { plugin as default };
