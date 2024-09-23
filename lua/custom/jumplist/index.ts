export function initCustomJumplist(this: void) {
  vim.api.nvim_create_user_command('JumpListClear', () => {
    vim.cmd(`tabdo windo clearjumps | tabnext`)
  }, {})
}
