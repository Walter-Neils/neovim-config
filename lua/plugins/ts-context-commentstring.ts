import { LazyPlugin } from "../../ambient/lazy";
import { useExternalModule } from "../helpers/module/useModule";

export function useTSContextCommentString() {
  type Module = {
    create_pre_hook: (this: void) => unknown,
    setup: (this: void, opts?: unknown) => void
  };

  return useExternalModule<Module>("ts_context_commentstring");
}

const plugin: LazyPlugin = {
  1: 'JoosepAlviste/nvim-ts-context-commentstring',
  event: 'BufRead',
  config: () => {
    useTSContextCommentString().setup({
      enable_autocmd: false
    });
  }
};
export { plugin as default };
