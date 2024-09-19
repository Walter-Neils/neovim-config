import { LazyPlugin } from "../../ambient/lazy";
import { useExternalModule } from "../helpers/module/useModule";
import { getTelescope } from "./telescope";

const plugin: LazyPlugin = {
  1: 'nvim-telescope/telescope-ui-select.nvim',
  event: "VimEnter",
  config: () => {
    getTelescope().load_extension("ui-select");
  }
};
export { plugin as default };
