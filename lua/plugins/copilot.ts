import { LazyPlugin } from "../../ambient/lazy";
import { getGlobalConfiguration } from "../helpers/configuration";
import { applyKeyMapping } from "../helpers/keymap";
import { setTimeout } from "../shims/mainLoopCallbacks";

if (getGlobalConfiguration().packages["copilot"]?.enabled ?? false) {
  const vim = getCopilotExtendedVimAPI();
  vim.notify("Copilot is enabled");
  vim.keymap.set('i', '<C-J>', 'copilot#Accept("<CR>")', {
    expr: true,
    replace_keycodes: false,
  });
  setTimeout(() => {
    applyKeyMapping({
      mode: 'i',
      inputStroke: '<C-J>',
      action: () => {
        // Accept the suggestion
        //if (config.packages["copilot"]?.enabled) {
        //  // TODO: Replace with custom remapper
        //  vim.keymap.set('i', '<C-J>', 'copilot#Accept("\<CR>")', {
        //    expr: true,
        //    replace_keycodes: false,
        //  });
        //}
        console.log(`Working`);
        const acceptFeedback = vim.fn["copilot#Accept"]() as string;
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes(acceptFeedback, true, true, true), '');
        //console.log(vim.fn["copilot#TextQueuedForInsertion"]() as string);
      }
    });
  }, 5000);
  vim.g.copilot_no_tab_map = true;
}

const plugin: LazyPlugin = {
  1: 'github/copilot.vim',
  event: 'VeryLazy',
  config: () => {

    // Change accept key to <CTRL-SPACE>
  }
};
export { plugin as default };

export function getCopilotExtendedVimAPI(this: void) {
  return vim as VimAPI & {
    g: {
      copilot_proxy: string,
      copilot_proxy_strict_ssl: boolean,
      copilot_no_tab_map: boolean,
    }
  };
}
