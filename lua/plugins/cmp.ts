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


const plugin: LazyPlugin = {
  1: 'Walter-Neils/nvim-cmp',
  dependencies: ['hrsh7th/cmp-nvim-lsp', 'neovim/nvim-lspconfig', 'onsails/lspkind.nvim', 'hrsh7th/cmp-vsnip', 'hrsh7th/vim-vsnip'],
  config: () => {
    const cmp = getCMP();
    cmp.setup({
      view: {
        entries: {
          vertical_positioning: 'above'
        }
      },
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
