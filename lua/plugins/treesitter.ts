import { LazyPlugin } from "../../ambient/lazy";
import { getGlobalConfiguration } from "../helpers/configuration";

const plugin: LazyPlugin = {
  1: 'nvim-treesitter/nvim-treesitter',
  opts: {
    autotag: {
      enable: getGlobalConfiguration().packages.tsAutoTag?.enabled ? true : undefined
    }
  }
};
export { plugin as default };
