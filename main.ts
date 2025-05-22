import { LazyModuleInterface } from "./ambient/lazy";
import { setupCustomLogic } from "./lua/custom";
import { loadEnvironmentSecrets } from "./lua/custom/secrets-loader";
import { getGlobalConfiguration } from "./lua/helpers/configuration";
import { setGUIFont } from "./lua/helpers/font";
import { useExternalModule } from "./lua/helpers/module/useModule";
import { createDiffOptString } from "./lua/helpers/vim-feature-unwrappers/diffopt";
import { Hyprland, isDesktopHyprland } from "./lua/integrations/hyprland";
import { getNeovideExtendedVimContext } from "./lua/integrations/neovide";
import { ollamaIntegration } from "./lua/integrations/ollama";
import { enablePortableAppImageLogic } from "./lua/integrations/portable-appimage";
import { getPlugins } from "./lua/plugins/init";
import { insertConsoleShims } from "./lua/shims/console";
import { insertJSONShims } from "./lua/shims/json";
import { insertMainLoopCallbackShims, setImmediate } from "./lua/shims/mainLoopCallbacks";
import { THEME_APPLIERS } from "./lua/theme";

insertJSONShims();
insertConsoleShims();
insertMainLoopCallbackShims();
enablePortableAppImageLogic();
loadEnvironmentSecrets();

function setupNeovide() {
  const vim = getNeovideExtendedVimContext();
  if (vim.g.neovide) {
    // If we're in a Neovide instance, we need to ignore TMUX environment variables (because even if they're set, we're not under the TMUX server)
    vim.env["TERM_PROGRAM"] = "neovide";
    vim.env["TERM"] = "xterm-256color";

    vim.g.neovide_scale_factor = 0.85;
    // Doesn't appear to be doing anything, but should leave remote nvim server instances intact when closing
    vim.g.neovide_detach_on_quit = 'always_detach';
    if (isDesktopHyprland()) {
      // Update Neovide's refresh rate to match the fastest monitor
      const targetRefresh = Math.max(...[...Hyprland.getRefreshRates(), 60]);
      vim.g.neovide_refresh_rate = targetRefresh;
    }
    // If you want to get a list of available fonts, run `set guifont=*`
    // setGUIFont("Source_Code_Pro", 14);
    setGUIFont("VictorMono_Nerd_Font_Mono", 14);

    //vim.g.neovide_cursor_animation_length = 0.05;
    //vim.g.neovide_scroll_animation_length = 0.05;
    //vim.g.neovide_scroll_animation_far_lines = 9999;
    //vim.g.neovide_floating_corner_radius = 10;
  }
}

function setupLazy(this: void) {
  const lazyPath = vim.fn.stdpath("data") + "/lazy/lazy.nvim";
  if (!vim.loop.fs_stat(lazyPath)) {
    const repo = "https://github.com/folke/lazy.nvim.git";
    vim.fn.system(["git", "clone", "--filter=blob:none", repo, "--branch=stable", lazyPath]);
  }
  // Append lazy to rtp so it can be loaded by plugins
  vim.opt.rtp.prepend(lazyPath);
}

vim.opt.diffopt = createDiffOptString({
  internal: true,
  filler: true,
  closeoff: true,
  indentHeuristic: true,
  lineMatch: 60,
  algorithm: 'histogram'
});


setupNeovide();
ollamaIntegration();
setupLazy();

const lazy = useExternalModule<LazyModuleInterface>("lazy");
lazy.setup(
  getPlugins()
);

THEME_APPLIERS[getGlobalConfiguration().theme.key]();


// unnamedplus is the default, but we'll set it here just in case
vim.opt.clipboard = "unnamedplus"; // System-wide copy & paste
// expandtab converts tabs to spaces, and shiftwidth is the number of spaces per tab
vim.opt.expandtab = true;
vim.opt.shiftwidth = 2;
// smartindent makes it so that when you press enter, the next line will be indented to match the previous line
vim.opt.smartindent = true;
// tabstop is the number of spaces that a tab character represents, and softtabstop is the number of spaces that pressing backspace will remove
vim.opt.tabstop = 2;
vim.opt.softtabstop = 2;
// Show line numbers in the gutter
vim.opt.number = true;
// Show relative line numbers in the gutter
vim.opt.relativenumber = true;
// Determines where the sign column is located, and how wide it should be
vim.opt.signcolumn = 'number';
vim.opt.numberwidth = 2;
// Ruler is a vertical line that shows the current position in the file
vim.opt.ruler = true;
vim.o.foldlevel = 99;
vim.o.foldlevelstart = 99;
vim.opt.cursorline = true;

require("mappings");

setImmediate(setupCustomLogic);
