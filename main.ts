import { LazyModuleInterface } from "./ambient/lazy";
import { activateWelcomePage } from "./components/welcome-page";
import { setupCustomLogic } from "./lua/custom";
import { getGlobalConfiguration } from "./lua/helpers/configuration";
import { useExternalModule } from "./lua/helpers/module/useModule";
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

insertJSONShims();
insertConsoleShims();
insertMainLoopCallbackShims();
enablePortableAppImageLogic();

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

if (!(getGlobalConfiguration().packages["copilot"]?.enabled ?? false)) {
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

require("mappings");

setImmediate(setupCustomLogic);


setImmediate(() => {
  const NUI = useNUI();

  const popup = NUI.Popup({
    border: {
      style: 'single',
      text: {
        top: 'Configuration',
      }
    },
    size: {
      width: '80%',
      height: '60%'
    },
    position: '50%',
    enter: true,
    buf_options: {
      readonly: true,
      modifiable: false
    }
  });



  popup.mount();
  const tree = NUI.Tree({
    winid: popup.winid,
    nodes: [
      NUI.Tree.Node({
        id: 'plugins',
        'text': 'Plugins'
      }, Object.keys(getGlobalConfiguration().packages).map((value) => {
        const plugin = getGlobalConfiguration().packages[value]!;
        return NUI.Tree.Node({
          id: value,
          text: `${plugin.enabled ? "" : ""} ${value}`
        })
      }))
    ]
  });

  tree.render();

  popup.on(NUI.event.event.BufWinLeave, () => {
    setImmediate(() => {
      popup.unmount();
    });
  });

  popup.map('n', 'l', () => {
    const selected = tree.get_node();
    if (selected == null) {
      console.error(`Null`);
      return;
    }
    if (typeof selected === 'number') {
      console.error(`Number`);
      return;
    } else {
      selected.expand();
      tree.render();
    }
  });
  popup.map('n', 'h', () => {
    const selected = tree.get_node();
    if (selected == undefined) {
      console.error(`undefined`);
      return;
    }
    else {
      selected.collapse();
      tree.render();
    }
  });
  popup.map('n', '<CR>', () => {
    const selected = tree.get_node();
    if (selected == undefined) {
      console.error(`undefined`);
      return;
    }
    else {
      if (selected.is_expanded()) {
        selected.collapse();
      }
      else {
        selected.expand();
      }
      tree.render();
    }
  });



  // const table = NUI.Table({
  //   bufnr: 0,
  //   columns: [{
  //     align: 'center',
  //     header: 'Name',
  //     columns: [
  //       {
  //         accessor_key: 'firstName',
  //         header: 'First'
  //       },
  //       {
  //         accessor_key: 'lastName',
  //         header: 'Last'
  //       }
  //     ]
  //   }],
  //   data: [{
  //     firstName: 'Walter',
  //     lastName: 'Neils',
  //     age: 20
  //   }]
  // });
  // table.render();

});
