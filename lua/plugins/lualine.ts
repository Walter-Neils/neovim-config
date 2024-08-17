import { LazyPlugin } from "../../ambient/lazy";
import { useExternalModule } from "../helpers/module/useModule";

const plugin: LazyPlugin = {
  1: 'nvim-lualine/lualine.nvim',
  dependencies: ['nvim-tree/nvim-web-devicons'],
  config: function(this: void) {
    const module = useExternalModule<{
      setup: (this: void, arg: unknown) => void
    }>("lualine");
    module.setup({
      options: {
        theme: 'material'
      }
    })
  }
};
export { plugin as default };
