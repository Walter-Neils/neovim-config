export function insertConsoleShims() {
  globalThis.console ??= {} as any;
  globalThis.console.log = message => {
    vim.notify(message, vim.log.levels.INFO);
  };
  globalThis.console.warn = message => {
    vim.notify(message, vim.log.levels.WARN);
  };
  globalThis.console.error = message => {
    vim.notify(message, vim.log.levels.ERROR);
  };
}
