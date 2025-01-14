import { LazyPlugin } from "../../ambient/lazy";
import { useExternalModule } from "../helpers/module/useModule";

function useTinyInlineDiagnostic() {
  type OptsType = {
    options?: {
      // Show the source of the diagnostic
      show_source?: boolean,
      // Throttle update rate of message per cursor move
      throttle?: number,
      // Show diagnostics on all lines
      multilines?: boolean,
      multiple_diag_under_cursor?: boolean
    }
  };
  type Module = {
    setup: (this: void, opts?: OptsType) => void
  };

  return useExternalModule<Module>("tiny-inline-diagnostic");
}

const plugin: LazyPlugin = {
  1: 'rachartier/tiny-inline-diagnostic.nvim',
  event: "VeryLazy", // The plugin page says "LspAttach" also works, but when I tried it the messages would only show for LSP servers after the first one had attached, making it pretty worthless.
  config: () => {
    useTinyInlineDiagnostic().setup({
      options: {
        multilines: true
      }
    });
  }
};
export { plugin as default };
