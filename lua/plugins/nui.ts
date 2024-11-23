import { LazyPlugin } from "../../ambient/lazy";
import { useExternalModule } from "../helpers/module/useModule";

type NUIBorder = {
  style: 'single' | 'double' | 'rounded',
  text?: {
    top?: string,
    top_align?: 'left' | 'center' | 'right'
  }
};

export type NUIElement = MountableUnmountable & {

};

type NUIElementCoreProps = {
  position?: string,
  size?: NUISize,
  win_options?: {
    winhighlight?: string
  },
  border?: NUIBorder
};

type MountableUnmountable = {
  mount: (this: any) => void,
  unmount: (this: any) => void,
};

type NUIPosition = {
  row: number,
  col: number
} | string | number;

type NUIPopupElement = NUIElement & MountableUnmountable & {
  map: (this: NUIPopupElement, arg1: string, arg2: string, callback: () => void) => void,
  on: (this: NUIPopupElement, ev: ReturnType<typeof useNUI>["event"]["event"][VimAutocmdEvent], callback: (this: void) => void) => void
  update_layout: (this: NUIPopupElement, config: {
    anchor: NUIAnchor,
    relative: NUIRelative,
    position: NUIPosition,
    size: NUISize
  }) => void,
  winid: number
};

type NUIRelative = 'cursor' | 'editor' | 'win' | {
  type: 'win',
  winid: number
} | {
  type: 'buf',
  position: {
    row: number,
    col: number
  }
};

type NUIAnchor = 'NW' | 'NE' | 'SW' | 'SE';

export type NUIPopupModule = {
} & ((this: void, props: {
  enter?: boolean,
  border: NUIBorder,
  position?: string | number,
  size?: NUISize,
  relative?: NUIRelative
  buf_options?: NUIBufOptions,
}) => NUIPopupElement);

type NUILayoutDirection = 'row' | 'column';
type NUISize = {
  width?: number | string,
  height?: number | string
}

type NUILayoutElement = NUIElement & MountableUnmountable & {
  update: (this: NUILayoutElement, root: NUIElement, opts: {
    dir: NUILayoutDirection
  }) => void,
  mount: (this: NUILayoutElement) => void
};

export type NUILayoutModule = {
  Box: (this: void, children: NUIElement[] | NUIElement, opts: {
    dir?: NUILayoutDirection,
    size?: number | string
  }) => NUIElement,
} & ((this: void, props: {
  position: string,
  size: NUISize
}, child: NUIElement) => NUILayoutElement);
type NUIInputElement = NUIElement & {
  on: (this: void, ev: NUIEvent, callback: (this: void) => void) => void
};
export type NUIInputModule = {

} & ((this: void, core_props: NUIElementCoreProps, props: {
  prompt?: string,
  default_value?: string,
  on_close?: (this: void) => void,
  on_submit?: (this: void, value: string) => void,
}) => NUIInputElement);
type NUIMenuItemElement = unknown;
type NUIMenuElement = NUIElement;
type NUIMenuSeparatorElement = unknown;

type NUIMenuItem = {
  text: string
};

type NUITableElement = {
  get_cell: (this: NUITableElement, position?: [number, number]) => NUITableCell | undefined,
  refresh_cell: (this: NUITableElement, cell: NUITableCell) => void,
  render: (this: NUITableElement, linenr_start?: number) => void,
};

type NUITableCell = {
  column: {
    id: unknown,
    accessor_key?: string
  },
  row: {
    original: unknown
  },
  get_value: (this: void) => unknown
};

export type NUITableColumnDef = ({
  id: string,
  accessor_fn: (this: void, row: unknown) => string | number,
} | {
  accessor_key: string,
} | {}) & {
  cell?: (this: void, cell: NUITableCell) => unknown,
  align?: 'center' | 'left' | 'right',
  columns?: NUITableColumnDef[],
  header: string
};

export type NUITableOptions = {
  bufnr: NeovimBuffer,
  ns_id?: number | string,
  columns: NUITableColumnDef[],
  data: unknown[],
};

type NUITableModule = {

} & ((this: void, opts: NUITableOptions) => NUITableElement);

export type NUIMenuModule = {
  item: (this: void, value: string, data?: unknown) => NUIMenuItemElement,
  separator: (this: void, text: string, opts: {
    char: string,
    text_align: 'left' | 'right' | 'center'
  }) => NUIMenuSeparatorElement,
} & ((this: void, core_props: NUIElementCoreProps, props: {
  lines: NUIMenuItemElement[],
  max_width?: number,
  keymap?: {
    focus_next: string[],
    focus_prev: string[],
    close: string[],
    submit: string[]
  },
  on_close?: (this: void) => void,
  on_submit?: (this: void, item: NUIMenuItem) => void
}) => NUIMenuElement);

type NUITreeElement = {
  get_node: (this: NUITreeElement, node_id_or_linenr?: number | string) => NUITreeNode | undefined,
  get_nodes: (this: NUITreeElement, parent_id?: string) => NUITreeNode[],
  add_node: (this: NUITreeElement, node: NUITreeNode, parent_id?: string) => void,
  remove_node: (this: NUITreeElement, node_id: string) => NUITreeNode | undefined,
  set_nodes: (this: NUITreeElement, nodes: NUITreeNode[], parent_id?: string) => void,
  render: (this: NUITreeElement, linenr_start?: number) => void
};

type NUITreeNodePrimaryOptions = {
  id: string
  text: string | string[]
};

type NUITreeNode = {
  get_id: (this: NUITreeNode) => string,
  get_depth: (this: NUITreeNode) => string,
  get_parent_id: (this: NUITreeNode) => string,
  has_children: (this: NUITreeNode) => boolean,
  get_child_ids: (this: NUITreeNode) => string[],
  is_expanded: (this: NUITreeNode) => boolean,
  expand: (this: NUITreeNode) => void,
  collapse: (this: NUITreeNode) => void
};

type NuiLine = unknown;

type NUIBufOptions = {
  bufhidden?: 'hide',
  buflisted?: boolean,
  buftype?: 'nofile' | string,
  swapfile?: boolean,
  readonly?: boolean,
  modifiable?: boolean
};

type NUITreeOptions = {
  nodes: NUITreeNode[],
  buf_options?: NUIBufOptions,
  get_node_id?: (this: void, node: NUITreeNode) => string,
  prepare_node?: (this: void, node: NUITreeNode, parent_node?: NUITreeNode) => undefined | string | string[] | NuiLine | NuiLine[]
} & ({
  bufnr: number,
} | {
  winid: number
});

type NUITreeModule = ((this: void, opts: NUITreeOptions) => NUITreeElement) & {
  Node: (this: void, opts: NUITreeNodePrimaryOptions, children?: NUITreeNode[]) => NUITreeNode
}

type NUILineElement = unknown;

type NUILineModule = {

} & ((this: void, elements: NUITextElement[]) => NUILineElement);

type NUITextElement = unknown;
type NUITextModule = {

} & ((this: void, value: string, hlGroup?: string) => NUITextElement)
type Mappable = {
  map: (mode: string, key: string, action: (this: void) => void) => void,
}
type NUISplitElement = {
  bufnr: NeovimBuffer,
} & MountableUnmountable & Mappable;

type NUISplitOpts = {
  position: 'top' | 'bottom' | 'left' | 'right',
  size: number,
};

type NUISplitModule = {

} & ((this: void, opts: NUISplitOpts) => NUISplitElement);
type NUIEvent = unknown;
export const useNUI = () => {
  return {
    Popup: useExternalModule("nui.popup") as NUIPopupModule,
    Layout: useExternalModule("nui.layout") as NUILayoutModule,
    Input: useExternalModule("nui.input") as NUIInputModule,
    Menu: useExternalModule("nui.menu") as NUIMenuModule,
    Table: useExternalModule("nui.table") as NUITableModule,
    Tree: useExternalModule("nui.tree") as NUITreeModule,
    Text: useExternalModule("nui.text") as NUITextModule,
    Line: useExternalModule("nui.line") as NUILineModule,
    Split: useExternalModule("nui.split") as NUISplitModule,
    event: useExternalModule("nui.utils.autocmd") as {
      event: {
        [key in VimAutocmdEvent]: NUIEvent
      }
    },
  };
}


const plugin: LazyPlugin = {
  1: 'MunifTanjim/nui.nvim',
};
export { plugin as default };
