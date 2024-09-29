import { LazyPlugin } from "../../ambient/lazy";
import { useExternalModule } from "../helpers/module/useModule";

function getLightbulb() {
  type LightbulbModule = {
    setup: (this: void, config: unknown) => void
  };

  return useExternalModule<LightbulbModule>("nvim-lightbulb");
}

const plugin: LazyPlugin = {
  1: 'kosayoda/nvim-lightbulb',
  event: "BufRead",
  config: () => {
    getLightbulb().setup({
      autocmd: {
        enabled: true
      }
    });
  }
};
export { plugin as default };
