export function insertConsoleShims() {
  globalThis.console ??= {
    log(message) {
      vim.notify(message, vim.log.levels.INFO);
    },
    warn(message) {
      vim.notify(message, vim.log.levels.WARN);
    },
    error(message) {
      vim.notify(message, vim.log.levels.ERROR);
    }
  };
}
