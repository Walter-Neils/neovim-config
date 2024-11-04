import { LazyPlugin } from "../../ambient/lazy";
import { useExternalModule } from "../helpers/module/useModule";

function useTreeSitterContextPlugin() {
  type TreeSitterContextModule = {
    setup: (this: void, opts: unknown) => void
  }

  return useExternalModule<TreeSitterContextModule>("treesitter-context");
}

const plugin: LazyPlugin = {
  1: 'nvim-treesitter/nvim-treesitter-context',
  event: 'VeryLazy',
  config: () => {
    useTreeSitterContextPlugin().setup({
      enabled: true,
      max_lines: 2,
      trim_scope: 'inner'
    });
  }
};
export { plugin as default };
