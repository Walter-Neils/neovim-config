type VIMDiagnosticConfig = {
  update_in_insert: boolean,
  virtual_text: boolean
};
type VimHLColorParams = {
  bg?: string,
  fg?: string,
  strikethrough?: boolean,
  link?: string
};

type VimAPI = {
  cmd: (this: void, params: string) => void,
  notify: (this: void, value: any) => void,
  api: {
    nvim_set_hl: (this: void, arg1: number, arg2: string, params: VimHLColorParams) => void,
    nvim_create_user_command: (this: void, commandName: string, luaFunc: (this: void, args?: unknown) => void, options?: {
      nargs?: number
    }) => void
  },
  lsp: {
    buf: {
      format: (this: void, opts: { async?: boolean }) => void,
      code_action: (this: void) => void,
      references: (this: void) => void,
      signature_help: (this: void) => void,
      hover: (this: void) => void,
      implementation: (this: void) => void,
      type_definition: (this: void) => void,
      inlay_hint: {
        enable: (this: void, enable: boolean, opt?: { bufnr: number }) => void
      }
    }
  },
  diagnostic: {
    config: (this: void, config: VIMDiagnosticConfig) => void,
    open_float: (this: void, opts: { border?: 'rounded' }) => void,
    goto_prev: (this: void, opts: { float?: { border?: 'rounded' } }) => void,
    goto_next: (this: void, opts: { float?: { border?: 'rounded' } }) => void,
    setloclist: (this: void) => void,
  },
  split: (this: void, input: string, token: string, opts: {
    trimempty: boolean
  }) => string[],
  snippit: {
    expand: (this: void, body: unknown) => unknown
  },
  keymap: {
    set: (this: void, mode: 'i' | 'n' | 'a' | 't', stroke: string, ...args: any[]) => void
  },
  ui: {
    input: (this: void, config: { prompt: string }, callback: (this: void, input: string) => void) => void
  },
  o: {
    shiftwidth: number
  },
  g: {
    mapleader: string,
  },
  fn: {
    system: (this: void, args: string[]) => void,
    stdpath: (this: void, target: string) => string,
  },
  loop: {
    fs_stat: (this: void, path: string) => boolean
  },
  opt: {
    // Run-time path
    rtp: {
      prepend: (path: string) => void
    },
    clipboard: string,
    cursorline: boolean
    expandtab: boolean,
    shiftwidth: number,
    smartindent: boolean,
    tabstop: number,
    softtabstop: number,
    fillchars: {
      eob: string
    },
    number: boolean,
    numberwidth: number,
    ruler: boolean
  }
}

declare var vim: VimAPI;
declare var tonumber: (this: void, input: any) => number;
declare var require: <ModuleType>(this: void, target: string) => ModuleType;
declare var string: { format: (this: void, pattern: string, ...args: string[]) => string };
