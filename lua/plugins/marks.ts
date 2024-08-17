import { LazyPlugin } from "../../ambient/lazy";
import { useExternalModule } from "../helpers/module/useModule";

const plugin: LazyPlugin = {
  1: 'chentoast/marks.nvim',
  config: function(this: void) {
    let target = "marks";
    useExternalModule<{ setup: (this: void) => void }>(target).setup();
  }
};
export { plugin as default };
