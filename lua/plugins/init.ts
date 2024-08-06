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
  return result;
}
