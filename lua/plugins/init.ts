import { LazyPlugin } from "../../ambient/lazy";
import { CONFIGURATION } from "../toggles";

export function getPlugins(this: void): LazyPlugin[] {
  const result: LazyPlugin[] = [];
  result.push(require<{ default: LazyPlugin }>('nvim-tree').default);
  result.push(require<{ default: LazyPlugin }>('floatterm').default);
  if (CONFIGURATION.useTelescope) {
    result.push(require<{ default: LazyPlugin }>('telescope').default);
  }
  result.push(require<{ default: LazyPlugin }>('treesitter').default);
  result.push(require<{ default: LazyPlugin }>('lspconfig').default);
  result.push(require<{ default: LazyPlugin }>('mason').default);
  result.push(require<{ default: LazyPlugin }>('autopairs').default);
  if (CONFIGURATION.useCMP) {
    result.push(require<{ default: LazyPlugin }>('cmp').default);
  }
  if (CONFIGURATION.useLSPLines) {
    result.push(require<{ default: LazyPlugin }>('lsp_lines').default);
  }
  if (CONFIGURATION.useLSPUI) {
    result.push(require<{ default: LazyPlugin }>('lspUI').default);
  }
  if (CONFIGURATION.useRustaceanvim) {
    result.push(require<{ default: LazyPlugin }>('rustaceanvim').default);
  }
  result.push(require<{ default: LazyPlugin }>('tokyonight').default);
  if (CONFIGURATION.useLSPSignature) {
    result.push(require<{ default: LazyPlugin }>('lsp_signature').default);
  }
  if (CONFIGURATION.useIndentBlankline) {
    result.push(require<{ default: LazyPlugin }>('indent-blankline').default);
  }
  if (CONFIGURATION.useTreeDevIcons) {
    result.push(require<{ default: LazyPlugin }>('nvim-tree-devicons').default);
  }
  if (CONFIGURATION.useLualine) {
    result.push(require<{ default: LazyPlugin }>('lualine').default);
  }
  if (CONFIGURATION.useBarBar) {
    result.push(require<{ default: LazyPlugin }>('barbar').default);
  }
  if (CONFIGURATION.useUFO) {
    result.push(require<{ default: LazyPlugin }>('ufo').default);
  }
  if (CONFIGURATION.useComments) {
    result.push(require<{ default: LazyPlugin }>('comment').default);
  }
  if (CONFIGURATION.useMarks) {
    result.push(require<{ default: LazyPlugin }>('marks').default);
  }
  if (CONFIGURATION.useTrouble) {
    result.push(require<{ default: LazyPlugin }>('trouble').default);
  }
  if (CONFIGURATION.useOutline) {
    result.push(require<{ default: LazyPlugin }>('outline').default);
  }
  if (CONFIGURATION.useGlance) {
    result.push(require<{ default: LazyPlugin }>('glance').default);
  }
  if (CONFIGURATION.useNvimDapUI) {
    result.push(require<{ default: LazyPlugin }>('nvim-dap-ui').default);
  }
  if (CONFIGURATION.useDiffView) {
    result.push(require<{ default: LazyPlugin }>('diffview').default);
  }
  if (CONFIGURATION.useLazyGit) {
    result.push(require<{ default: LazyPlugin }>('lazygit').default);
  }
  if (CONFIGURATION.useNoice) {
    result.push(require<{ default: LazyPlugin }>('noice').default);
  }
  if (CONFIGURATION.useNoice) {
    result.push(require<{ default: LazyPlugin }>('copilot').default);
  }
  return result;
}
