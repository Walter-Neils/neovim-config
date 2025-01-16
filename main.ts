import { LazyModuleInterface } from "./ambient/lazy";
import { setupCustomLogic } from "./lua/custom";
import { getGlobalConfiguration } from "./lua/helpers/configuration";
import { setGUIFont } from "./lua/helpers/font";
import { useExternalModule } from "./lua/helpers/module/useModule";
import { Hyprland, isDesktopHyprland } from "./lua/integrations/hyprland";
import { getNeovideExtendedVimContext } from "./lua/integrations/neovide";
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

function setupNeovide() {
  const vim = getNeovideExtendedVimContext();
  if (vim.g.neovide) {
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
const lazy = useExternalModule<LazyModuleInterface>("lazy");
lazy.setup(
  getPlugins()
);


THEME_APPLIERS[getGlobalConfiguration().theme.key]();

vim.opt.clipboard = "unnamedplus"; // System-wide copy & paste
vim.opt.expandtab = true;
vim.opt.shiftwidth = 2;
vim.opt.smartindent = true;
vim.opt.tabstop = 2;
vim.opt.softtabstop = 2;
vim.opt.number = true;
vim.opt.relativenumber = true;
vim.opt.signcolumn = 'number';
vim.opt.numberwidth = 2;
vim.opt.ruler = false;
vim.o.foldlevel = 99;
vim.o.foldlevelstart = 99;

require("mappings");

setImmediate(setupCustomLogic);
