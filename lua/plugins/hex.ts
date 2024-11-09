import { LazyPlugin } from "../../ambient/lazy";
import { useExternalModule } from "../helpers/module/useModule";

function useHexPlugin() {
  type HexModule = {
    setup: (this: void) => void
  }

  return useExternalModule<HexModule>("hex");
}

const plugin: LazyPlugin = {
  1: 'RaafatTurki/hex.nvim',
  event: 'VeryLazy',
  cmd: ["HexDump", "HexAssemble", "HexToggle"],
  config: () => {
    if (!vim.fn.executable("xxd")) {
      vim.notify("xxd utility is required for hex editor functionality", vim.log.levels.ERROR);
      return;
    }
    useHexPlugin().setup();
  }
};
export { plugin as default };
