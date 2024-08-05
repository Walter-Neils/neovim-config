import { LazyModuleInterface } from "./ambient/lazy";
import { getNeovideExtendedVimContext } from "./lua/integrations/neovide";
import { getPlugins } from "./lua/plugins/init";
import { THEME_APPLIERS } from "./lua/theme";


vim.api.nvim_create_user_command('ResetInstallData', function(this: void) {
  vim.notify("Configuration reset");
}, {});

function setupNeovide() {
  const vim = getNeovideExtendedVimContext();
  if (vim.g.neovide) {
    vim.g.neovide_scale_factor = 0.75;
    vim.g.neovide_transparency = 0.8;
    vim.g.neovide_detach_on_quit = 'always_detach';
  }
}

function setupLazy(this: void) {
  const lazyPath = vim.fn.stdpath("data") + "/lazy/lazy.nvim";
  if (!vim.loop.fs_stat(lazyPath)) {
    const repo = "https://github.com/folke/lazy.nvim.git";
    vim.fn.system(["git", "clone", "--filter=blob:none", repo, "--branch=stable", lazyPath]);
  }
  vim.opt.rtp.prepend(lazyPath);
}

setupNeovide();
setupLazy();
const lazy = require<LazyModuleInterface>("lazy");
lazy.setup(
  getPlugins()
);

THEME_APPLIERS.TokyoNight();

vim.opt.clipboard = "unnamedplus"; // System-wide copy & paste

vim.opt.expandtab = true;
vim.opt.shiftwidth = 2;
vim.opt.smartindent = true;
vim.opt.tabstop = 2;
vim.opt.softtabstop = 2;
vim.opt.number = true;
vim.opt.numberwidth = 2;
vim.opt.ruler = false;

require<unknown>("mappings");
