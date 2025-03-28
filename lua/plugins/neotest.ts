import { LazyPlugin } from "../../ambient/lazy";
import { getGlobalConfiguration } from "../helpers/configuration";
import { useExternalModule } from "../helpers/module/useModule";

export function useNeotest() {
  type NeoTestModule = {
    setup: (this: void, opts?: unknown) => void
  };
  return useExternalModule<NeoTestModule>("neotest");
}

const plugin: LazyPlugin = {
  1: 'nvim-neotest/neotest',
  dependencies: [
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
  ],
};
export { plugin as default };
