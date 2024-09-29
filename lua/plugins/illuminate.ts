import { LazyPlugin } from "../../ambient/lazy";
import { useExternalModule } from "../helpers/module/useModule";

function getIlluminate() {
  type IlluminateModule = {
    configure: (this: void, opts?: unknown) => void
  };

  return useExternalModule<IlluminateModule>("illuminate");
}

const plugin: LazyPlugin = {
  1: 'RRethy/vim-illuminate',
  event: "BufEnter",
  config: () => {
    getIlluminate().configure({
      delay: 100
    });
  }
};
export { plugin as default };
