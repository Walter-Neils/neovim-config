import { LazyPlugin } from "../../ambient/lazy";
import { useExternalModule } from "../helpers/module/useModule";
type CMPSource = { name: string };
type CMPMappingActionType = (this: void, fallback: (this: void) => void) => void;
type CMPMappingModeInsertion = {
  [key: string]: (this: void, fallback: (this: void) => void) => void
} | ((this: void, fallback: (this: void) => void) => void);
type CMPModule = {
  setup: (this: void, config: any) => void,
  config: {
    sources: (this: void, sources: CMPSource[]) => void
  },
  mapping: {
    preset: {
      insert: (this: void, mapping: CMPMappingModeInsertion) => void
    },
    scroll_docs: (this: void, distance: number) => CMPMappingActionType,
    complete: (this: void) => CMPMappingActionType,
    abort: (this: void) => CMPMappingActionType,
    confirm: (this: void, opt: { select: boolean }) => CMPMappingActionType
  } & ((this: void, map: CMPMappingModeInsertion) => CMPMappingActionType),
  visible: (this: void) => boolean,
  select_next_item: (this: void) => void,
  get_selected_entry: (this: void) => unknown,
};


const KIND_ICONS = {
  Text: "",
  Method: "󰆧",
  Function: "󰊕",
  Constructor: "",
  Field: "󰇽",
  Variable: "󰂡",
  Class: "󰠱",
  Interface: "",
  Module: "",
  Property: "󰜢",
  Unit: "",
  Value: "󰎠",
  Enum: "",
  Keyword: "󰌋",
  Snippet: "",
  Color: "󰏘",
  File: "󰈙",
  Reference: "",
  Folder: "󰉋",
  EnumMember: "",
  Constant: "󰏿",
  Struct: "",
  Event: "",
  Operator: "󰆕",
  TypeParameter: "󰅲",
}

export function getCMP() {
  const cmp = useExternalModule<CMPModule>("cmp");
  return cmp;
}
type CompletionItemKindID = 'Variable' | 'Parameter' | 'Snippet' | 'Method' | 'Struct' | 'Constant' | 'Module' | 'Enum' | 'Reference' | 'Function' | 'Interface' | 'Keyword' | 'EnumMember';
export function getCMPTypes() {
  type Kind = string;
  type LspTypes = {
    CompletionItemKind: {
      [key: Kind]: CompletionItemKindID
    }
  };
  type CMPTypesModule = {
    lsp: LspTypes
  };
  return useExternalModule<CMPTypesModule>("cmp.types");
}

function lspKindComparator(this: void) {
  const lspTypes = getCMPTypes().lsp;
  type Kind = unknown;
  type EntryCompletionItem = {
    label: string
  };
  type Entry = {
    source: {
      name: string
    },
    get_kind(): string,
    get_completion_item(): EntryCompletionItem
  };
  const PRIORITIES: {
    [key in CompletionItemKindID]: number
  } = {
    Parameter: -5,
    Variable: -5,
    Snippet: 100,
    Method: -5,
    Module: 0,
    Enum: 0,
    Struct: 0,
    Constant: 50,
    Reference: -5,
    Function: -5,
    Interface: 0,
    Keyword: 0,
    EnumMember: 0
  };
  const alreadyNotified: string[] = [];
  const getPriority = (key: CompletionItemKindID) => {
    if (key === null) {
      return 0;
    }
    const priority = PRIORITIES[key];
    if (priority === undefined && !alreadyNotified.includes(key)) {
      console.warn(`No priority specified for '${key}'`);
      alreadyNotified.push(key);
    }
    return -(priority ?? 0);
  };
  return function(this: void, entry1: Entry, entry2: Entry): boolean | null {
    //if (entry1.source.name === "nvim_lsp") {
    //  if (entry2.source.name === "nvim_lsp") {
    //    return false;
    //  }
    //  else {
    //    return null;
    //  }
    //}

    const kindExpander = (kind: CompletionItemKindID, entry: Entry): CompletionItemKindID => {
      if (kind == 'Variable' && (entry.get_completion_item().label as unknown as { match(pattern: string): boolean }).match("%w*=")) {
        return 'Parameter';
      }
      return kind;
    };
    const kind1 = kindExpander(lspTypes.CompletionItemKind[entry1.get_kind()], entry1);
    const kind2 = kindExpander(lspTypes.CompletionItemKind[entry2.get_kind()], entry2);
    const priority1 = getPriority(kind1);
    const priority2 = getPriority(kind2);
    if (priority1 === priority2) {
      return null;
    }
    return priority2 < priority1;
  }
}

const plugin: LazyPlugin = {
  1: 'hrsh7th/nvim-cmp',
  dependencies: ['hrsh7th/cmp-nvim-lsp', 'neovim/nvim-lspconfig', 'onsails/lspkind.nvim', 'hrsh7th/cmp-vsnip', 'hrsh7th/vim-vsnip'],
  config: () => {
    const cmp = getCMP();
    cmp.setup({
      window: {
        completion: {
          winhighlight: "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
          col_offset: -3,
          side_padding: 0
        }
      },
      formatting: {
        format: function(this: void, _entry: any, vim_item: any) {
          const target_icon = KIND_ICONS[vim_item.kind as keyof typeof KIND_ICONS];
          let icon: string = target_icon ?? "?";
          icon = ` ${icon} `;
          vim_item.menu = `  (${vim_item.kind})  `;
          vim_item.kind = string.format("%s %s", icon, vim_item.kind);
          return vim_item;
        }
      },
      snippet: {
        expand: function(this: void, args: any) {
          ((vim.fn as any)["vsnip#anonymous"] as (this: void, arg: any) => void)(args.body);
        }
      },
      sources: cmp.config.sources([
        { name: 'nvim_lsp' }
      ]),
      sorting: {
        comparators: [
          lspKindComparator()
        ]
      },
      completion: {
        autocomplete: false
      },
      mapping: {
        '<C-b>': cmp.mapping.scroll_docs(-4),
        '<C-f>': cmp.mapping.scroll_docs(1),
        '<C-Space>': cmp.mapping.complete(),
        '<Tab>': cmp.mapping(function(this: void, fallback: (this: void) => void) {
          if (cmp.visible()) {
            cmp.select_next_item();
          }
          else {
            fallback();
          }
        }),
        '<C-e>': cmp.mapping.abort(),
        '<CR>': cmp.mapping.confirm({ select: false })
      }
    });
  }
};




export { plugin as default };
