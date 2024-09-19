import { LazyPlugin } from "../../ambient/lazy";
import { useExternalModule } from "../helpers/module/useModule";

type TelescopeOpts = {
  extensions: {
    [key: string]: unknown
  },
};

export function getTelescope() {
  type TelescopeModule = {
    setup: (this: void, opts: TelescopeOpts) => void,
    load_extension: (this: void, key: string) => void
  };
  return useExternalModule<TelescopeModule>("telescope");
}

const plugin: LazyPlugin = {
  1: 'nvim-telescope/telescope.nvim',
  dependencies: ['nvim-lua/plenary.nvim'],
  config: () => {
    getTelescope().setup({
      extensions: {
        ["ui-select"]: [
          useExternalModule<{ get_dropdown: (this: void, args?: unknown) => void }>("telescope.themes").get_dropdown({})
        ]
      }
    });
  }
};
export { plugin as default };
