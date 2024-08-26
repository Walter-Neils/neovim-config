import { LazyPlugin } from "../../ambient/lazy";
import { useExternalModule } from "../helpers/module/useModule";

type NUIBorder = {
  style: 'single' | 'double',
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
  }) => void
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

export const useNUI = () => {
  return {
    Popup: useExternalModule("nui.popup") as NUIPopupModule,
    Layout: useExternalModule("nui.layout") as NUILayoutModule,
    Input: useExternalModule("nui.input") as NUIInputModule,
    Menu: useExternalModule("nui.menu") as NUIMenuModule,
    event: useExternalModule("nui.utils.autocmd") as {
      event: {
        [key in VimAutocmdEvent]: unknown
      }
    }
  };
}


const plugin: LazyPlugin = {
  1: 'MunifTanjim/nui.nvim',
};
export { plugin as default };
