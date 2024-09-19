import { LazyPlugin } from "../../ambient/lazy";
import { useExternalModule } from "../helpers/module/useModule";

export function getMasonNvimDap(this: void) {
  type MasonNvimDapModule = {
    setup: (this: void, opts?: {
      ensure_installed: string[]
    }) => void
  };
  return useExternalModule<MasonNvimDapModule>("mason-nvim-dap");
}

const plugin: LazyPlugin = {
  1: 'jay-babu/mason-nvim-dap.nvim',
  event: "InsertEnter",
  dependencies: ["williamboman/mason.nvim", "mfussenegger/nvim-dap"],
  config: () => {
    getMasonNvimDap().setup({ ensure_installed: ['node2', 'firefox', 'cppdbg', 'js', 'codelldb'] })
  }
};
export { plugin as default };
