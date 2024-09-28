import { applyKeyMapping } from "../../helpers/keymap";

export function initCustomGit() {
  applyKeyMapping({
    mode: 'n',
    inputStroke: '<c-c>',
    action: () => {
      vim.ui.input({ prompt: 'Commit Message: ' }, message => {
        if (message === undefined || message.length < 1) {
          return;
        }
        else {
          vim.notify(vim.fn.system(["git", "add", "--all"]));
          vim.notify(vim.fn.system(["git", "commit", "-m", message]));
        }
      });
    },
    options: {
      desc: 'Commit'
    }
  })
}
