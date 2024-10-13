function h(this: void, name: string) {
  return vim.api.nvim_get_hl(0, { name: name });
}

type ThemeMetaType = 'light' | 'dark';

let themeType: ThemeMetaType = 'dark';

type ThemeUpdateCallback = (this: void, type: ThemeMetaType) => void;

const callbacks: ThemeUpdateCallback[] = [];

export function onThemeChange(this: void, callback: ThemeUpdateCallback) {
  callbacks.push(callback);
}

function updateThemeType(type: ThemeMetaType) {
  themeType = type;
  for (const callback of callbacks) {
    callback(type);
  }
}

export function globalThemeType() {
  return themeType;
}

function VSCode(this: void) {
  vim.api.nvim_set_hl(0, 'CmpItemAbbrDeprecated', {
    bg: 'NONE',
    strikethrough: true,
    fg: '#808080'
  });
  vim.api.nvim_set_hl(0, 'CmpItemAbbrDeprecated', { bg: 'NONE', strikethrough: true, fg: '#808080' })
  vim.api.nvim_set_hl(0, 'CmpItemAbbrMatch', { bg: 'NONE', fg: '#569CD6' })
  vim.api.nvim_set_hl(0, 'CmpItemAbbrMatchFuzzy', { link: 'CmpIntemAbbrMatch' })
  vim.api.nvim_set_hl(0, 'CmpItemKindVariable', { bg: 'NONE', fg: '#9CDCFE' })
  vim.api.nvim_set_hl(0, 'CmpItemKindInterface', { link: 'CmpItemKindVariable' })
  vim.api.nvim_set_hl(0, 'CmpItemKindText', { link: 'CmpItemKindVariable' })
  vim.api.nvim_set_hl(0, 'CmpItemKindFunction', { bg: 'NONE', fg: '#C586C0' })
  vim.api.nvim_set_hl(0, 'CmpItemKindMethod', { link: 'CmpItemKindFunction' })
  vim.api.nvim_set_hl(0, 'CmpItemKindKeyword', { bg: 'NONE', fg: '#D4D4D4' })
  vim.api.nvim_set_hl(0, 'CmpItemKindProperty', { link: 'CmpItemKindKeyword' })
  vim.api.nvim_set_hl(0, 'CmpItemKindUnit', { link: 'CmpItemKindKeyword' })
  updateThemeType('dark');
}

function TokyoNight(this: void) {
  vim.cmd('colorscheme tokyonight-storm');
  updateThemeType('dark');

  vim.api.nvim_set_hl(0, 'DapBreakpoint', { ctermbg: 0, fg: '#993939', bg: '#31353f' });
  vim.api.nvim_set_hl(0, 'DapLogPoint', { ctermbg: 0, fg: '#61afef', bg: '#31353f' });
  vim.api.nvim_set_hl(0, 'DapStopped', { ctermbg: 0, fg: '#98c379', bg: '#31353f' });
  vim.fn.sign_define('DapBreakpoint', { text: '', texthl: 'DapBreakpoint', linehl: 'DapBreakpoint', numhl: 'DapBreakpoint' });
  vim.fn.sign_define('DapBreakpointCondition', { text: 'ﳁ', texthl: 'DapBreakpoint', linehl: 'DapBreakpoint', numhl: 'DapBreakpoint' });
  vim.fn.sign_define('DapBreakpointRejected', { text: '', texthl: 'DapBreakpoint', linehl: 'DapBreakpoint', numhl: 'DapBreakpoint' });
  vim.fn.sign_define('DapLogPoint', { text: '', texthl: 'DapLogPoint', linehl: 'DapLogPoint', numhl: 'DapLogPoint' });
  vim.fn.sign_define('DapStopped', { text: '', texthl: 'DapStopped', linehl: 'DapStopped', numhl: 'DapStopped' });

  vim.api.nvim_set_hl(0, 'SymbolUsageRounding', { fg: h('CursorLine').bg, italic: true } as any)
  vim.api.nvim_set_hl(0, 'SymbolUsageContent', { bg: h('CursorLine').bg, fg: h('Comment').fg, italic: true } as any);
  vim.api.nvim_set_hl(0, 'SymbolUsageRef', { fg: h('Function').fg, bg: h('CursorLine').bg, italic: true } as any);
  vim.api.nvim_set_hl(0, 'SymbolUsageDef', { fg: h('Type').fg, bg: h('CursorLine').bg, italic: true } as any);
  vim.api.nvim_set_hl(0, 'SymbolUsageImpl', { fg: h('@keyword').fg, bg: h('CursorLine').bg, italic: true } as any);

  vim.o.fillchars = "eob: ,fold: ,foldopen:,foldsep: ,foldclose:";
}

function Catppuccin(this: void) {
  vim.cmd("colorscheme catppuccin");
  vim.o.fillchars = "eob: ,fold: ,foldopen:,foldsep: ,foldclose:";
  updateThemeType('dark');
}


export const THEME_APPLIERS = {
  VSCode,
  TokyoNight,
  Catppuccin
}
