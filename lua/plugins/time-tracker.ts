import { LazyPlugin } from "../../ambient/lazy";
import { useExternalModule } from "../helpers/module/useModule";

const plugin: LazyPlugin = {
  1: '3rd/time-tracker.nvim',
  dependencies: ['3rd/sqlite.nvim'],
  event: "VeryLazy",
  cmd: ["TimeTracker"],
  config: () => {
    useExternalModule<{ setup: (this: void, opts: unknown) => void }>("time-tracker").setup({
      data_file: vim.fn.stdpath("data") + "/time-tracker.db",
      tracking_events: ["BufEnter", "BufWinEnter", "CursorMoved", "CursorMovedI", "WinScrolled"],
      tracking_timeout_seconds: 5 * 1000
    });
  }
};
export { plugin as default };
