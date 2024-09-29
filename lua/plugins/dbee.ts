import { LazyPlugin } from "../../ambient/lazy";
import { useExternalModule } from "../helpers/module/useModule";

function getDbee() {
  type DBeeModule = {
    install: (this: void) => void;
    setup: (this: void, config?: unknown) => void;
  };
  return useExternalModule<DBeeModule>("dbee");
}

const plugin: LazyPlugin = {
  1: 'kndndrj/nvim-dbee',
  dependencies: ['MunifTanjim/nui.nvim'],
  build: () => {
    return getDbee().install()
  },
  config: () => {
    return getDbee().setup()
  }
};
export { plugin as default };
