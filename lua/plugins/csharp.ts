import { LazyPlugin } from "../../ambient/lazy";
import { getGlobalConfiguration } from "../helpers/configuration";
import { useExternalModule } from "../helpers/module/useModule";
import { setImmediate } from "../shims/mainLoopCallbacks";

export function getCSharp(this: void) {
  type CSharpModule = {
    setup: (this: void) => void,
    debug_project: (this: void) => void
  };
  return useExternalModule<CSharpModule>("csharp");
}

const plugin: LazyPlugin = {
  1: 'iabdelkareem/csharp.nvim',
  dependencies: ["williamboman/mason.nvim", "mfussenegger/nvim-dap", "Tastyep/structlog.nvim"],
  config: function(this: void) {
    if (getGlobalConfiguration().packages.mason?.enabled) {
      if (!vim.fn.executable("fd")) {
        setImmediate(() => {
          console.error("[plugin/cSharp] Initialization not allowed: fd is required, but cannot be found in the current path.");
        });
      }
      else {
        getCSharp().setup();
      }
    }
    else {
      setImmediate(() => {
        console.error("[plugin/cSharp] Initialization not allowed: mason is required, but has been disabled.");
      });
    }
  }
};
export { plugin as default };
