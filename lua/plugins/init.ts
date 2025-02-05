import { LazyPlugin } from "../../ambient/lazy";
import { getGlobalConfiguration } from "../helpers/configuration";

type PluginRef = {
  key?: string,
  include: string,
};

export function getPlugins(this: void): LazyPlugin[] {
  const globalConfig = getGlobalConfiguration();
  const result: LazyPlugin[] = [];

  const targets: PluginRef[] = [
    {
      include: 'copilot-lualine',
      key: 'copilotLuaLine'
    },
    {
      include: 'nui'
    }, {
      key: 'screenkey',
      include: 'screenkey'
    }, {
      key: 'outline',
      include: 'outline'
    },
    {
      key: 'presence',
      include: 'presence'
    },
    {
      key: 'dropBar',
      include: 'dropbar'
    },
    {
      key: 'gotoPreview',
      include: 'goto-preview'
    },
    {
      key: 'treesitterContext',
      include: 'treesitter-context'
    },
    {
      key: 'fidget',
      include: 'fidget'
    },
    {
      key: 'hex',
      include: 'hex'
    },
    {
      key: 'tinyInlineDiagnostic',
      include: 'tiny-inline-diagnostic'
    },
    {
      key: 'flatten',
      include: 'flatten'
    },
    {
      key: 'rest',
      include: 'rest'
    },
    {
      key: 'hlchunk',
      include: 'hlchunk'
    },
    {
      key: 'overseer',
      include: 'overseer'
    },
    {
      key: 'nvimDapVirtualText',
      include: 'dap-virtual-text'
    },
    {
      key: 'tsContextCommentString',
      include: 'ts-context-commentstring'
    },
    {
      key: 'neogen',
      include: 'neogen'
    },
    {
      key: 'lightbulb',
      include: 'lightbulb'
    },
    {
      key: 'dbee',
      include: 'dbee'
    },
    {
      key: 'crates',
      include: 'crates'
    },
    {
      key: 'todoComments',
      include: 'todo-comments'
    },
    {
      key: 'iconPicker',
      include: 'icon-picker'
    },
    {
      key: 'treesj',
      include: 'treesj'
    },
    {
      include: 'tokyonight'
    },
    {
      include: 'catppuccin'
    },
    {
      include: 'theme-flow'
    },
    {
      include: 'kanagawa'
    },
    {
      include: 'nord'
    },
    {
      key: 'treeSitter',
      include: 'treesitter'
    },
    {
      key: 'lspConfig',
      include: 'lspconfig'
    },
    {
      key: 'autoPairs',
      include: 'autopairs'
    },
    {
      key: 'floatTerm',
      include: 'floatterm'
    },
    {
      key: 'nvimTree',
      include: 'nvim-tree'
    },
    {
      key: 'telescope',
      include: 'telescope'
    },
    {
      key: 'mason',
      include: 'mason'
    },
    {
      key: 'cmp',
      include: 'cmp'
    },
    {
      key: 'lspLines',
      include: 'lsp_lines'
    },
    {
      key: 'lspUI',
      include: 'lspUI'
    },
    {
      key: 'rustaceanvim',
      include: 'rustaceanvim'
    },
    {
      key: 'lspSignature',
      include: 'lsp_signature'
    },
    {
      key: 'indentBlankline',
      include: 'indent-blankline'
    },
    {
      key: 'treeDevIcons',
      include: 'nvim-tree-devicons'
    },
    {
      key: 'luaLine',
      include: 'lualine'
    },
    {
      key: 'barBar',
      include: 'barbar'
    },
    {
      key: 'ufo',
      include: 'ufo'
    },
    {
      key: 'comment',
      include: 'comment'
    },
    {
      key: 'marks',
      include: 'marks'
    },
    {
      key: 'trouble',
      include: 'trouble'
    },
    {
      key: 'glance',
      include: 'glance'
    },
    {
      key: 'nvimDapUI',
      include: 'nvim-dap-ui'
    },
    {
      key: 'diffView',
      include: 'diffview'
    },
    {
      key: 'lazygit',
      include: 'lazygit'
    },
    {
      key: 'noice',
      include: 'noice'
    },
    {
      key: 'copilot',
      include: 'copilot'
    },
    {
      key: 'actionsPreview',
      include: 'actions-preview'
    },
    {
      key: 'fireNvim',
      include: 'firenvim'
    },
    {
      key: 'nvimNotify',
      include: 'nvim-notify'
    },
    {
      key: 'markdownPreview',
      include: 'markdown-preview'
    },
    {
      key: 'gitBrowse',
      include: 'git-browse'
    },
    {
      key: 'obsidian',
      include: 'obsidian'
    },
    {
      key: 'undoTree',
      include: 'undotree'
    },
    {
      key: 'octo',
      include: 'octo'
    },
    {
      key: 'leap',
      include: 'leap'
    },
    {
      key: 'cSharp',
      include: 'csharp'
    },
    {
      key: 'telescopeUISelect',
      include: 'telescope-ui-select'
    },
    {
      key: 'masonNvimDap',
      include: 'mason-nvim-dap'
    },
    {
      key: 'timeTracker',
      include: 'time-tracker'
    },
    {
      key: 'wakaTime',
      include: 'wakatime'
    },
    {
      key: 'surround',
      include: 'surround'
    },
    {
      key: 'tsAutoTag',
      include: 'ts-autotag'
    },
    {
      key: 'ultimateAutoPair',
      include: 'ultimate-autopair'
    },
    {
      key: 'rainbowDelimiters',
      include: 'rainbow-delimiters'
    },
    {
      key: 'markview',
      include: 'markview'
    },
    {
      key: 'symbolUsage',
      include: 'symbol-usage'
    },
    {
      key: 'neotest',
      include: 'neotest'
    },
    {
      key: 'navic',
      include: 'navic'
    },
    {
      key: 'illuminate',
      include: 'illuminate'
    }
  ];

  const activeTargets = targets.filter(x => x.key === undefined || globalConfig.packages[x.key]?.enabled);

  vim.api.nvim_create_user_command("WinPlugStats", () => {
    vim.notify(`Using ${targets.length} plugin definitions, ${activeTargets.length} of which are enabled`, vim.log.levels.INFO);
  }, {
    nargs: 0
  });

  for (const target of activeTargets) {
    try {
      result.push((require("lua.plugins." + target.include) as { default: any }).default);
    } catch {
      vim.notify(`Failed to include plugin '${target.key ?? target.include}' (${target.include})`);
    }
  }
  return result;
}
