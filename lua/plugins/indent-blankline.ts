import { LazyPlugin } from "../../ambient/lazy";
import { useExternalModule } from "../helpers/module/useModule";

const plugin: LazyPlugin = {
  1: 'lukas-reineke/indent-blankline.nvim',
  version: "^3",
  config: function(this: void) {
    const ibl = useExternalModule<{
      setup: (this: void, opts?: unknown) => void
    }>("ibl");
    ibl.setup()
  }
};
export { plugin as default };
