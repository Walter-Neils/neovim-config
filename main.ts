import { LazyModuleInterface } from "./ambient/lazy";
import { activateWelcomePage } from "./components/welcome-page";
import { setupCustomLogic } from "./lua/custom";
import { useExternalModule } from "./lua/helpers/module/useModule";
import { usePersistentValue } from "./lua/helpers/persistent-data";
import { Hyprland, isDesktopHyprland } from "./lua/integrations/hyprland";
import { getNeovideExtendedVimContext } from "./lua/integrations/neovide";
import { setupOllamaCopilot } from "./lua/integrations/ollama";
import { enablePortableAppImageLogic } from "./lua/integrations/portable-appimage";
import { getPlugins } from "./lua/plugins/init";
import { useNUI } from "./lua/plugins/nui";
import { insertConsoleShims } from "./lua/shims/console";
import { insertJSONShims } from "./lua/shims/json";
import { insertMainLoopCallbackShims, setImmediate, setInterval, setTimeout } from "./lua/shims/mainLoopCallbacks";
import { THEME_APPLIERS } from "./lua/theme";
import { CONFIGURATION } from "./lua/toggles";

insertJSONShims();
insertConsoleShims();
insertMainLoopCallbackShims();

enablePortableAppImageLogic();

vim.cmd("map w <Nop>");
vim.cmd("map W <Nop>");

const [getValue, setValue] = usePersistentValue('test', 'testing');
setValue("test");

function setupNeovide() {
  const vim = getNeovideExtendedVimContext();
  if (vim.g.neovide) {
    vim.g.neovide_scale_factor = 0.75;
    // Doesn't appear to be doing anything, but should leave remote nvim server instances intact when closing
    vim.g.neovide_detach_on_quit = 'always_detach';

    if (isDesktopHyprland()) {
      // Update Neovide's refresh rate to match the fastest monitor
      const targetRefresh = Math.max(...Hyprland.getRefreshRates());
      vim.g.neovide_refresh_rate = targetRefresh;
    }
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
setupOllamaCopilot();

if (!CONFIGURATION.useCopilot) {
  // Once installed by Lazy, Copilot can't be prevented from loading without uninstalling it, so we've gotta do a little hack
  // It'll still get loaded, but it won't be active for any filetypes, which I consider to be good enough.
  (vim.g as unknown as { copilot_filetypes: Record<string, boolean> }).copilot_filetypes = { '*': false };
}


setupLazy();
const lazy = useExternalModule<LazyModuleInterface>("lazy");
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
vim.opt.relativenumber = true;
vim.opt.signcolumn = 'number';
vim.opt.numberwidth = 2;
vim.opt.ruler = false;

activateWelcomePage();
// vim.o.whichwrap.append("<>[]hl");

require("mappings");
require("commands");

if (CONFIGURATION.behaviour.shell.target === 'tmux') {
  const term = os.getenv("TERM") ?? '__term_value_not_supplied';
  if (!term.includes('tmux')) {
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
    // Running `tmux` as the terminal provider would cause nesting, which is NOT desirable. 
  }
}

setImmediate(setupCustomLogic);
// setTimeout(() => {
//   const NUI = useNUI();
//   const popup = NUI.Popup({
//     relative: 'cursor',
//     border: {
//       style: 'single',
//       text: {
//         top: 'Yep'
//       }
//     },
//     size: {
//       width: 5,
//       height: 5
//     },
//     position: 0
//   });
//
//   popup.mount();
//
//   for (const event of ["CursorMoved", "CursorMovedI"] as const) {
//     vim.api.nvim_create_autocmd(event, {
//       callback: () => {
//         setImmediate(() => {
//           popup.update_layout({
//             relative: 'cursor',
//             size: {
//               width: 3,
//               height: 1,
//             },
//             position: {
//               row: 0,
//               col: 0
//             },
//             anchor: 'NE'
//           })
//         });
//       }
//     })
//   }
// }, 2500);
