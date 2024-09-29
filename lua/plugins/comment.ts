import { LazyPlugin } from "../../ambient/lazy";
import { useExternalModule } from "../helpers/module/useModule";
import { useTSContextCommentString } from "./ts-context-commentstring";

function getComments() {
  return useExternalModule<{
    setup: (this: void, opts?: unknown) => void
  }>("Comment");
}

const plugin: LazyPlugin = {
  1: 'numToStr/Comment.nvim',
  event: 'InsertEnter',
  config: () => {
    getComments().setup({
      pre_hook: useExternalModule<{ create_pre_hook: (this: void) => unknown }>("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()
    });
  }
};
export { plugin as default };
