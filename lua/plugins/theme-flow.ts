import { LazyPlugin } from "../../ambient/lazy";
import { useExternalModule } from "../helpers/module/useModule";

const plugin: LazyPlugin = {
  1: '0xstepit/flow.nvim',
  lazy: false,
  priority: 1000,
  opts: {},
  config: () => {
    type FlowModule = {
      setup: (this: void, opts?: unknown) => void
    };
    useExternalModule<FlowModule>("flow").setup({
      dark_theme: true,
      high_contrast: false,
      transparent: true,
      fluo_color: 'pink',
      mode: 'base',
      aggressive_spell: false
    });
  }
};
export { plugin as default };
