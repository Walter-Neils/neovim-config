import { LazyPlugin } from "../../ambient/lazy";
import { useExternalModule } from "../helpers/module/useModule";
type SUSymbol = {
  stacked_count: number,
  references?: number,
  definition?: number,
  implementation?: number
};

function h(this: void, name: string) {
  return vim.api.nvim_get_hl(0, { name: name });
}

vim.api.nvim_set_hl(0, 'SymbolUsageRounding', { fg: h('CursorLine').bg, italic: true } as any)
vim.api.nvim_set_hl(0, 'SymbolUsageContent', { bg: h('CursorLine').bg, fg: h('Comment').fg, italic: true } as any);
vim.api.nvim_set_hl(0, 'SymbolUsageRef', { fg: h('Function').fg, bg: h('CursorLine').bg, italic: true } as any);
vim.api.nvim_set_hl(0, 'SymbolUsageDef', { fg: h('Type').fg, bg: h('CursorLine').bg, italic: true } as any);
vim.api.nvim_set_hl(0, 'SymbolUsageImpl', { fg: h('@keyword').fg, bg: h('CursorLine').bg, italic: true } as any);

function textFormat(this: void, symbol: SUSymbol) {
  const result: any[] & { [key: string]: any | undefined } = [];
  let roundStart = ['', 'SymbolUsageRounding'] as const;
  let roundEnd = ['', 'SymbolUsageRounding'] as const;
  let stackedFunctionsContent = symbol.stacked_count > 0 ? `${symbol.stacked_count}` : '';
  if (symbol.references !== undefined) {
    const usage = symbol.references <= 1 ? 'usage' : 'usages';
    const num = symbol.references === 0 ? 'no' : symbol.references;
    result.push(roundStart);
    result.push(['󰌹 ', 'SymbolUsageRef']);
    result.push([`${num} ${usage}`, 'SymbolUsageContent']);
    result.push(roundEnd);
  }
  if (symbol.definition) {
    if (result.length > 0) {
      result.push([' ', 'NonText']);
    }
    result.push(roundStart);
    result.push(['󰳽 ', 'SymbolUsageDef']);
    result.push([symbol.definition + ' defs', 'SymbolUsageContent'])
    result.push(roundEnd);
  }
  if (symbol.implementation) {
    if (result.length > 0) {
      result.push([' ', 'NonText']);
    }
    result.push(roundStart);
    result.push(['󰡱 ', 'SymbolUsageImpl']);
    result.push([symbol.implementation + ' impls', 'SymbolUsageContent']);
    result.push(roundEnd);
  }
  if (stackedFunctionsContent.length > 0) {
    if (result.length > 0) {
      result.push([' ', 'NonText']);
    }
    result.push(roundStart);
    result.push([' ', 'SymbolUsageImpl']);
    result.push([stackedFunctionsContent, 'SymbolUsageContent']);
    result.push(roundEnd);
  }

  return result;
}

const plugin: LazyPlugin = {
  1: 'Wansmer/symbol-usage.nvim',
  event: 'LspAttach',
  config: function(this: void) {
    useExternalModule<{ setup: (this: void, args?: unknown) => void }>("symbol-usage").setup({
      text_format: textFormat
    });
  }
};
export { plugin as default };
