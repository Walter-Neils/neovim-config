import { parseArgs } from "./lua/helpers/user_command/argparser";
import { CONFIGURATION } from "./lua/toggles";

if (CONFIGURATION.customCommands.installDefaultLSPServers.enabled) {
  // Install LSP servers specified in configuration with Mason
  vim.api.nvim_create_user_command('InstallDefaultLSPServers', function(this: void) {
    for (const server of CONFIGURATION.mason.defaultInstalled) {
      vim.cmd(`MasonInstall ${server}`);
    }
  }, { nargs: 0 });
}

if (CONFIGURATION.customCommands.fixRustAnalyzer.enabled) {
  vim.api.nvim_create_user_command('FixRustAnalyzer', function(this: void) {
    for (const component of ['rust-analyzer', 'rustfmt']) {
      vim.notify(`Installing component ${component}`);
      vim.fn.system(["rustup", "component", "add", component]);
    }
  }, { nargs: 0 })
}

if (CONFIGURATION.customCommands.resetInstall.enabled) {
  vim.api.nvim_create_user_command('ResetCurrentInstall', function(this: void) {
    if (vim.fn.input("To reset this install, type 'reset': ") === 'reset') {
      vim.fn.system(["rm", "-rf", vim.fn.stdpath("data")])
      vim.cmd("norm :qa!");
    }
  }, {});
}

vim.api.nvim_create_user_command('TestFunction', function(this: void, _args) {
  const args = parseArgs<{
    name: string
  }>(_args.fargs);
  vim.notify(`Hello, ${args.name}`);
}, { nargs: '*' });
