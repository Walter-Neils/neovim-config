import { LazyModuleInterface } from "./ambient/lazy";
import { getNeovideExtendedVimContext } from "./lua/integrations/neovide";
import { enablePortableAppImageLogic } from "./lua/integrations/portable-appimage";
import { getPlugins } from "./lua/plugins/init";
import { THEME_APPLIERS } from "./lua/theme";
import { CONFIGURATION } from "./lua/toggles";

enablePortableAppImageLogic();

function setupNeovide() {
  const vim = getNeovideExtendedVimContext();
  if (vim.g.neovide) {
    vim.g.neovide_scale_factor = 0.75;
    // Doesn't appear to be doing anything, but should leave remote nvim server instances intact when closing
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

// vim.o.whichwrap.append("<>[]hl");

require<unknown>("mappings");
require<unknown>("commands");

if (CONFIGURATION.behaviour.shell.target === 'tmux') {
  const term = os.getenv("TERM") ?? '__term_value_not_supplied';
  if (!term.includes('tmux')) {
    vim.print(`Setup: using terminal emulator 'tmux'`);
    vim.g.terminal_emulator = 'tmux';
    const isolationScope = CONFIGURATION.behaviour.shell.tmux.isolation.scope as 'global' | 'neovim-shared' | 'per-instance';
    if (isolationScope === 'global') {
      vim.o.shell = 'tmux';
    }
    else if (isolationScope === 'neovim-shared') {
      vim.o.shell = 'tmux -L neovim';
    }
    else if (isolationScope === 'per-instance') {
      vim.o.shell = `tmux -L neovim-${vim.fn.getpid()}`
    }
    else {
      vim.notify(`Invalid option '${isolationScope}' for tmux isolation scope.`);
      vim.o.shell = 'tmux';
    }
  } else {
    vim.print(`Setup: terminal tmux would nest if applied. skipping...`);
  }
}
