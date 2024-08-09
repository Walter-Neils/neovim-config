import { applyKeyMapping } from "./lua/helpers/keymap";
import { parseArgs } from "./lua/helpers/user_command/argparser";
import { CONFIGURATION } from "./lua/toggles";

// Install LSP servers specified in configuration with Mason
vim.api.nvim_create_user_command('WINInstallDefaultLSPServers', function(this: void) {
  for (const server of CONFIGURATION.mason.defaultInstalled) {
    vim.cmd(`MasonInstall ${server}`);
  }
}, { nargs: 0 });

vim.api.nvim_create_user_command('Test', function(this: void, args) {
  const parsed = parseArgs<{ name: string }>(args.fargs);
  vim.notify(parsed.name);
}, {
  nargs: '*'
})

