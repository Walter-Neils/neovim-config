import { LazyPlugin } from "../../ambient/lazy";
import { getGlobalConfiguration } from "../helpers/configuration";
import { setImmediate } from "../shims/mainLoopCallbacks";

export function getPlugins(this: void): LazyPlugin[] {
  const globalConfig = getGlobalConfiguration();
  const result: LazyPlugin[] = [];
  result.push(require("tokyonight").default);
  if (globalConfig.packages.treeSitter?.enabled) {
    result.push(require("treesitter").default);
  }
  if (globalConfig.packages.lspConfig?.enabled) {
    result.push(require("lspconfig").default);
  }
  if (globalConfig.packages.autoPairs?.enabled) {
    result.push(require("autopairs").default);
  }
  if (globalConfig.packages.floatTerm?.enabled) {
    result.push(require("floatterm").default);
  }
  if (globalConfig.packages.nvimTree?.enabled) {
    result.push(require("nvim-tree").default);
  }
  if (globalConfig.packages.telescope?.enabled) {
    result.push(require("mason").default);
  }
  if (globalConfig.packages.telescope?.enabled) {
    result.push(require("telescope").default);
  }
  if (globalConfig.packages.cmp?.enabled) {
    result.push(require("cmp").default);
  }
  if (globalConfig.packages.lspLines?.enabled) {
    result.push(require("lsp_lines").default);
  }
  if (globalConfig.packages.lspUI?.enabled) {
    result.push(require("lspUI").default);
  }
  if (globalConfig.packages.rustaceanvim?.enabled) {
    result.push(require("rustaceanvim").default);
  }
  if (globalConfig.packages.lspSignature?.enabled) {
    result.push(require("lsp_signature").default);
  }
  if (globalConfig.packages.indentBlankline?.enabled) {
    result.push(require("indent-blankline").default);
  }
  if (globalConfig.packages.treeDevIcons?.enabled) {
    result.push(require("nvim-tree-devicons").default);
  }
  if (globalConfig.packages.luaLine?.enabled) {
    result.push(require("lualine").default);
  }
  if (globalConfig.packages.barBar?.enabled) {
    result.push(require("barbar").default);
  }
  if (globalConfig.packages.ufo?.enabled) {
    result.push(require("ufo").default);
  }
  if (globalConfig.packages.comments?.enabled) {
    result.push(require("comment").default);
  }
  if (globalConfig.packages.marks?.enabled) {
    result.push(require("marks").default);
  }
  if (globalConfig.packages.trouble?.enabled) {
    result.push(require("trouble").default);
  }
  if (globalConfig.packages.outline?.enabled) {
    result.push(require("outline").default);
  }
  if (globalConfig.packages.glance?.enabled) {
    result.push(require("glance").default);
  }
  if (globalConfig.packages.nvimDapUI?.enabled) {
    result.push(require("nvim-dap-ui").default);
  }
  if (globalConfig.packages.diffView?.enabled) {
    result.push(require("diffview").default);
  }
  if (globalConfig.packages.lazyGit?.enabled) {
    result.push(require("lazygit").default);
  }
  if (globalConfig.packages.noice?.enabled) {
    result.push(require("noice").default);
  }
  if (globalConfig.packages.copilot?.enabled) {
    result.push(require("copilot").default);
  }
  if (globalConfig.packages.actionsPreview?.enabled) {
    result.push(require("actions-preview").default);
  }
  if (globalConfig.packages.fireNvim?.enabled) {
    result.push(require("firenvim").default);
  }
  if (globalConfig.packages.nvimNotify?.enabled) {
    result.push(require("nvim-notify").default);
  }
  if (globalConfig.packages.markdownPreview?.enabled) {
    result.push(require("markdown-preview").default);
  }
  if (globalConfig.packages.gitBrowse?.enabled) {
    result.push(require("git-browse").default);
  }
  if (globalConfig.packages.obsidian?.enabled) {
    result.push(require("obsidian").default);
  }
  if (globalConfig.packages.undoTree?.enabled) {
    result.push(require("undotree").default);
  }
  if (globalConfig.packages.octo?.enabled) {
    result.push(require("octo").default);
  }
  if (globalConfig.packages.leap?.enabled) {
    result.push(require("leap").default);
  }
  if (globalConfig.packages.cSharp?.enabled) {
    result.push(require("csharp").default);
  }
  if (globalConfig.packages.telescopeUISelect?.enabled) {
    result.push(require("telescope-ui-select").default);
  }
  if (globalConfig.packages.masonNvimDap?.enabled) {
    result.push(require("mason-nvim-dap").default);
  }
  if (globalConfig.packages.timeTracker?.enabled) {
    result.push(require("time-tracker").default);
  }
  if (globalConfig.packages.wakaTime?.enabled) {
    result.push(require("wakatime").default);
  }
  if (globalConfig.packages.surround?.enabled) {
    result.push(require("surround").default);
  }
  if (globalConfig.packages.tsAutoTag?.enabled) {
    result.push(require("ts-autotag").default);
  }
  if (globalConfig.packages.ultimateAutoPair?.enabled) {
    result.push(require("ultimate-autopair").default);
  }
  if (globalConfig.packages.rainbowDelimiters?.enabled) {
    result.push(require("rainbow-delimiters").default);
  }
  if (globalConfig.packages.markview?.enabled) {
    result.push(require("markview").default);
  }
  if (globalConfig.packages.symbolUsage?.enabled) {
    result.push(require("symbol-usage").default);
  }
  if (globalConfig.packages.neotest?.enabled) {
    result.push(require("neotest").default);
  }
  if (globalConfig.packages.navic?.enabled) {
    result.push(require("navic").default);
  }


  result.push(require("nui").default);
  return result;
}
