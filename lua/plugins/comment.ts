import { LazyPlugin } from "../../ambient/lazy";
import { useExternalModule } from "../helpers/module/useModule";

function getComments() {
  return useExternalModule<{
    setup: (this: void, opts?: unknown) => void
  }>("Comment");
}

const plugin: LazyPlugin = {
  1: 'numToStr/Comment.nvim',
  config: () => {
    getComments().setup();
  }
};
export { plugin as default };
