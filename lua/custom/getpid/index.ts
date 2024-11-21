export function initCustomGetPIDCommand(this: void) {
  vim.api.nvim_create_user_command('GetPID', () => {
    vim.notify(`PID: ${vim.fn.getpid()}`);
  }, {
    nargs: 0
  });
}
