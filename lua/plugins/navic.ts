import { LazyPlugin } from "../../ambient/lazy";
import { getGlobalConfiguration } from "../helpers/configuration";
import { useExternalModule } from "../helpers/module/useModule";

export function getNavic() {
  type NavicModule = {
    attach: (this: void, client: NvimLspClient, buffer: NeovimBuffer) => void,
    setup: (this: void, opts?: unknown) => void,
    get_location: (this: void) => string,
    is_available: (this: void) => boolean
  };
  if (getGlobalConfiguration().packages.navic?.enabled) {
    return useExternalModule<NavicModule>("nvim-navic");
  }
  else {
    return undefined;
  }
}

const plugin: LazyPlugin = {
  1: 'SmiteshP/nvim-navic',
  event: "InsertEnter",
  config: () => {
    getNavic()!.setup({});
  }
};
export { plugin as default };
