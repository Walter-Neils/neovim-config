import { LazyPlugin } from "../../ambient/lazy";
import { CONFIGURATION } from "../toggles";

export function getPlugins(this: void): LazyPlugin[] {
  const result: LazyPlugin[] = [];
  result.push(require('nvim-tree').default);
  result.push(require('floatterm').default);
  if (CONFIGURATION.useTelescope) {
    result.push(require('telescope').default);
  }
  result.push(require('treesitter').default);
  result.push(require('lspconfig').default);
  result.push(require('mason').default);
  result.push(require('autopairs').default);
  if (CONFIGURATION.useCMP) {
    result.push(require('cmp').default);
  }
  if (CONFIGURATION.useLSPLines) {
    result.push(require('lsp_lines').default);
  }
  if (CONFIGURATION.useLSPUI) {
    result.push(require('lspUI').default);
  }
  if (CONFIGURATION.useRustaceanvim) {
    result.push(require('rustaceanvim').default);
  }
  result.push(require('tokyonight').default);
  if (CONFIGURATION.useLSPSignature) {
    result.push(require('lsp_signature').default);
  }
  if (CONFIGURATION.useIndentBlankline) {
    result.push(require('indent-blankline').default);
  }
  if (CONFIGURATION.useTreeDevIcons) {
    result.push(require('nvim-tree-devicons').default);
  }
  if (CONFIGURATION.useLualine) {
    result.push(require('lualine').default);
  }
  if (CONFIGURATION.useBarBar) {
    result.push(require('barbar').default);
  }
  if (CONFIGURATION.useUFO) {
    result.push(require('ufo').default);
  }
  if (CONFIGURATION.useComments) {
    result.push(require('comment').default);
  }
  if (CONFIGURATION.useMarks) {
    result.push(require('marks').default);
  }
  if (CONFIGURATION.useTrouble) {
    result.push(require('trouble').default);
  }
  if (CONFIGURATION.useOutline) {
    result.push(require('outline').default);
  }
  if (CONFIGURATION.useGlance) {
    result.push(require('glance').default);
  }
  if (CONFIGURATION.useNvimDapUI) {
    result.push(require('nvim-dap-ui').default);
  }
  if (CONFIGURATION.useDiffView) {
    result.push(require('diffview').default);
  }
  if (CONFIGURATION.useLazyGit) {
    result.push(require('lazygit').default);
  }
  if (CONFIGURATION.useNoice) {
    result.push(require('noice').default);
  }
  if (CONFIGURATION.useNoice) {
    result.push(require('copilot').default);
  }
  if (CONFIGURATION.useActionsPreview) {
    result.push(require('actions-preview').default);
  }
  if (CONFIGURATION.useFireNvim) {
    result.push(require('firenvim').default);
  }
  return result;
}
