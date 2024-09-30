import { LazyPlugin } from "../../ambient/lazy";
import { useExternalModule } from "../helpers/module/useModule";

const plugin: LazyPlugin = {
  1: 'kylechui/nvim-surround',
  version: '*',
  event: ['VeryLazy', 'InsertEnter'],
  config: () => {
    useExternalModule<{ setup: (this: void, opts?: unknown) => void }>("nvim-surround").setup({});
  }
};
export { plugin as default };
