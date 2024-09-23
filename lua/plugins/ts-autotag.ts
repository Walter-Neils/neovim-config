import { LazyPlugin } from "../../ambient/lazy";
import { useExternalModule } from "../helpers/module/useModule";

const plugin: LazyPlugin = {
  1: 'windwp/nvim-ts-autotag',
  event: "VimEnter",
  config: () => {
    type TSAutoTagModule = {
      setup: (this: void, args: unknown) => void
    };
    useExternalModule<TSAutoTagModule>('nvim-ts-autotag').setup({});
    // TODO: Create documentation for making this thing work correctly on install.
    // Requires installing treesitter parsers for `typescript` and `tsx` before it works, but doesn't produce any errors if
    // those aren't installed. Just silently fails to work.
  }
};
export { plugin as default };
