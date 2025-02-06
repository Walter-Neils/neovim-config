type VIMDiagnosticConfig = {
  update_in_insert?: boolean,
  virtual_text?: boolean,
  virtual_lines?: boolean
};
type VimHLColorParams = {
  bg?: string,
  fg?: string,
  strikethrough?: boolean,
  link?: string,
  ctermbg?: number
};

type VimLSPProtocolClientCapabilities = {
  textDocument: {
    foldingRange: {
      dynamicRegistration: boolean,
      lineFoldingOnly: boolean
    }
  }
};

type NvimWindowInfo = {
  variables: {
    [key: string]: unknown
  },
  tabnr: number,
  winrow: number,
  textoff: number,
  winid: number,
  winbar: number,
  quickfix: number,
  loclist: number,
  bufnr: number,
  terminal: number,
  height: number,
  winnr: number,
  wincol: number,
  botline: number,
  width: number,
  topline: number
};

type VimLoopSpawnHandle = {
  close: (this: VimLoopSpawnHandle) => void,
  kill: (this: VimLoopSpawnHandle, signum?: number) => void,
};

type VimUVTimer = {
  start: (this: VimUVTimer, initial_delay: number, interval: number, callback: (this: void) => void) => void,
};

type VimUVTcp = {
  bind: (this: VimUVTcp, host: string, port: number) => void,
  listen: (this: VimUVTcp, arg1: number, on_connect: (this: void, err?: unknown) => void) => void,
  accept: (this: VimUVTcp, socket: VimUVTcp) => void,
  write: (this: VimUVTcp, chunk: unknown) => void,
  close: (this: VimUVTcp) => void,
  getsockname: (this: VimUVTcp) => { port: number };
  read_start: (this: VimUVTcp, callback: (err?: unknown, chunk?: unknown) => void) => void
};

type VimUVScanDirResult = {

};
type VimUVScanDirNextResult = LuaMultiReturn<[name: undefined, type: undefined] | [name: string, type: 'file' | 'directory']>;

type VimUV = {
  new_timer: (this: void) => VimUVTimer,
  new_tcp: (this: void) => VimUVTcp,
  fs_scandir: (this: void, directory: string) => VimUVScanDirResult | undefined,
  fs_scandir_next: (this: void, handle: VimUVScanDirResult) => VimUVScanDirNextResult,
};

type NeovimBuffer = unknown;
type NeovimWindow = unknown;

type NvimOptionInfo = {
  allows_duplicates: false,
  last_set_sid: number,
  default: string,
  was_set: string,
  shortname: string,
  global_local: boolean,
  flaglist: boolean,
  scope: 'global' | 'local',
  last_set_chan: number,
  last_set_linenr: number,
  name: string,
  type: 'string' | 'number' | 'boolean',
  commalist: boolean
};

type NeovimHighlightGroup = {
  fg: unknown,
  bg: unknown
};

type VimAuGroup = {

};

type NvimLspClientRPC = {

};
type NvimLspClientRequests = unknown;

type NvimLspClientHandlers = unknown;

type NvimLspClientConfig = unknown;

type NvimLspClientCapabilities = unknown;

type NvimLspClientProgress = unknown;

type NvimLspClientWorkspaceFolders = unknown;

type NvimLspClientAttachedBuffers = Record<string, true>;

type LspCommand = unknown;

type NvimLspClientCommands = Record<string, (command: LspCommand, ctx: unknown) => void>

type VimUISelectFunction = <TOptionType>(this: void, options: TOptionType[], cfg: {
  prompt: string,
  format_item?: (this: void, item: TOptionType) => string,
}, on_choice: (this: void, choice: TOptionType | undefined) => void) => void

type NvimLspClient = {
  id: number,
  name: string,
  rpc: NvimLspClientRPC,
  offset_encoding: string,
  handlers: NvimLspClientHandlers,
  requests: NvimLspClientRequests,
  config: NvimLspClientConfig
  server_capabilities: {
    documentSymbolProvider: boolean,
    inlayHintProvider: boolean
  },
  capabilities: NvimLspClientCapabilities,
  progress: NvimLspClientProgress,
  workspaceFolders: NvimLspClientWorkspaceFolders,
  attached_buffers: NvimLspClientAttachedBuffers,
  commands: NvimLspClientCommands,
  // WIP
  // :h vim.lsp.client

};

type NvimTreeSitterObj = {
  language: {
    register: (this: void, language: string, buf_type: string) => void
  }
};

type NvimBufOption = '';

type VimRegex = {
  match_str: (this: VimRegex, str: string) => boolean,
};

type VimPipe = unknown;

type VimAutocmdEvent = 'BufAdd' | 'BufDelete' | 'BufEnter' | 'BufFilePost' | 'BufFilePre' | 'BufHidden' | 'BufLeave' | 'BufModifiedSet' | 'BufNew' | 'BufNewFile' | 'BufRead' | 'BufReadCmd' | 'BufReadPre' | 'BufUnload' | 'BufWinEnter' | 'BufWinLeave' | 'BufWipeout' | 'BufWrite' | 'BufWriteCmd' | 'BufWritePost' | 'ChanInfo' | 'ChanOpen' | 'CmdUndefined' | 'CmdlineChanged' | 'CmdlineEnter' | 'CmdlineLeave' | 'CmdwinEnter' | 'CmdwinLeave' | 'ColorScheme' | 'ColorSchemePre' | 'CompleteChanged' | 'CompleteDonePre' | 'CompleteDone' | 'CursorHold' | 'CursorHoldI' | 'CursorMoved' | 'CursorMovedI' | 'DiffUpdated' | 'DirChanged' | 'DirChangedPre' | 'ExitPre' | 'FileAppendCmd' | 'FileAppendPost' | 'FileAppendPre' | 'FileChangedRO' | 'FileChangedShell' | 'FileChangedShellPost' | 'FileReadCmd' | 'FileReadPost' | 'FileReadPre' | 'FileType' | 'FileWriteCmd' | 'FileWritePost' | 'FileWritePre' | 'FilterReadPost' | 'FilterReadPre' | 'FilterWritePost' | 'FilterWritePre' | 'FocusGained' | 'FocusLost' | 'FuncUndefined' | 'UIEnter' | 'UILeave' | 'InsertChange' | 'InsertCharPre' | 'InsertEnter' | 'InsertLeavePre' | 'InsertLeave' | 'MenuPopup' | 'ModeChanged' | 'OptionSet' | 'QuickFixCmdPre' | 'QuickFixCmdPost' | 'QuitPre' | 'RemoteReply' | 'SearchWrapped' | 'RecordingEnter' | 'RecordingLeave' | 'SafeState' | 'SessionLoadPost' | 'SessionWritePost' | 'ShellCmdPost' | 'Signal' | 'ShellFilterPost' | 'SourcePre' | 'SourcePost' | 'SourceCmd' | 'SpellFileMissing' | 'StdinReadPost' | 'StdinReadPre' | 'SwapExists' | 'Syntax' | 'TabEnter' | 'TabLeave' | 'TabNew' | 'TabNewEntered' | 'TabClosed' | 'TermOpen' | 'TermEnter' | 'TermLeave' | 'TermClose' | 'TermRequest' | 'TermResponse' | 'TextChanged' | 'TextChangedI' | 'TextChangedP' | 'TextChangedT' | 'TextYankPost' | 'User' | 'UserGettingBored' | 'VimEnter' | 'VimLeave' | 'VimLeavePre' | 'VimResized' | 'VimResume' | 'VimSuspend' | 'WinClosed' | 'WinEnter' | 'WinLeave' | 'WinNew' | 'WinScrolled' | 'WinResized' | 'LspAttach' | 'LspDetach';

type VimFnJobStartOpts = {
  clear_env?: boolean,
  cwd?: string,
  detach?: boolean,
  env?: Record<string, string>,
  height?: number,
  on_stdout?: (this: void, channel_id: number, data: string, name: 'stdout' | 'stderr' | 'stdin') => void,
  on_stderr?: (this: void, channel_id: number, data: string, name: 'stdout' | 'stderr' | 'stdin') => void,
  on_stdin?: (this: void, channel_id: number, data: string, name: 'stdout' | 'stderr' | 'stdin') => void,
  on_exit?: (this: void, channel_id: number, code: number, signal: string) => void,
  pty?: boolean
  rpc?: boolean
  stderr_buffered?: boolean,
  stdout_buffered?: boolean,
  stdin?: VimPipe | undefined,
  width?: number
};

type VimVersion = {
  prerelease: string,
  build: string,
  api_compatible: number,
  api_level: number,
  api_prerelease: boolean,
  major: number,
  minor: number,
  patch: number
};

type VimAPI = {
  treesitter: NvimTreeSitterObj,
  cmd: ((this: void, params: string) => void) & {
    [key: string]: (this: void, ...args: unknown[]) => unknown
  },
  version: (this: void) => VimVersion,
  notify: (this: void, value: string | [string, string], level?: VimAPI["log"]["levels"][keyof VimAPI["log"]["levels"]]) => void,
  print: (this: void, value: any) => void,
  schedule: (this: void, callback: (this: void) => void) => void,
  defer_fn: (this: void, callback: (this: void) => void, ms: number) => void,
  tbl_deep_extend: <T1, T2>(this: void, behaviour: 'error' | 'keep' | 'force', table1: T1, table2: T2) => T1 & T2,
  regex: (this: void, pattern: string) => VimRegex,
  env: { [key: string]: string | undefined },
  bo: {
    [key: string]: unknown | undefined
  },
  uv: VimUV,
  json: {
    encode: (this: void, value: unknown) => string,
    decode: (this: void, value: string) => unknown,
  },
  v: {
    shell_error: number,
    swapname: string,
    afile: string,
    // Swapchoice values:
    // 'o' - open read-only
    // 'e' - edit
    // 'r' - recover
    // 'd' - delete
    // 'q' - quit
    // 'a' - abandon
    // '' - do nothing
    swapchoice: 'o' | 'e' | 'r' | 'd' | 'q' | 'a' | ''
  },
  log: {
    levels: {
      INFO: Symbol,
      WARN: Symbol,
      ERROR: Symbol
    }
  },
  api: {
    // Replaces termcodes in a string with the appropriate special key codes
    nvim_replace_termcodes: (this: void, str: string, from_particular_key: boolean, from_remapped_mode: boolean, from_expr: boolean) => string,
    // Returns a highlight group by name
    nvim_get_hl: (this: void, arg1: number, arg2: { name: string }) => NeovimHighlightGroup,
    // Calls a VimL function
    nvim_call_function: (this: void, command: string, args?: unknown[]) => unknown,
    // Fetches the current line
    nvim_get_current_line: (this: void) => number,
    // Fetches the current line number
    nvim_get_all_options_info: (this: void) => { [key: string]: NvimOptionInfo }
    nvim_set_hl: (this: void, arg1: number, arg2: string, params: VimHLColorParams) => void,
    nvim_create_user_command: (this: void, commandName: string, luaFunc: (this: void, args: { fargs: string[] }) => void, options: {
      nargs?: number | '+' | '*',
      bang?: boolean
    }) => void,
    nvim_create_autocmd: (this: void, eventName: VimAutocmdEvent, config: {
      pattern?: string,
      group?: string | VimAuGroup,
      callback: (this: void, args?: unknown) => void
    }) => void,
    nvim_create_augroup: (this: void, name: string, opts: { clear?: boolean }) => VimAuGroup,
    nvim_win_get_cursor: (this: void, arg1: number) => number[],
    nvim_get_current_buf: (this: void) => NeovimBuffer,
    nvim_create_buf: (this: void, listed: boolean, scratch: boolean) => NeovimBuffer,
    nvim_buf_set_option: (this: void, buffer: NeovimBuffer, ev: Lowercase<VimAutocmdEvent>, action: string) => void,
    nvim_win_set_option: (this: void, win: NeovimWindow, ev: Lowercase<VimAutocmdEvent>, value: string) => void,
    nvim_set_option_value: (this: void, name: string, value: unknown, opts: {
      scope?: 'global' | 'local',
      win?: number,
      buf?: number
    }) => void,
    nvim_buf_set_lines: (this: void, buf: NeovimBuffer, start: number, end: number, strict_indexing: boolean, values: string[]) => void,
    nvim_buf_get_lines: (this: void, buf: NeovimBuffer, start: number, end: number, strict_indexing: boolean) => string[],
    nvim_buf_line_count: (this: void, buf: NeovimBuffer) => number,
    nvim_buf_set_name: (this: void, buf: NeovimBuffer, name: string) => void,
    nvim_buf_delete: (this: void, buf: number | NeovimBuffer, opts: { force?: boolean }) => void,
    nvim_set_current_buf: (this: void, buf: number | NeovimBuffer) => void,
    nvim_win_get_width: (this: void, win: number | NeovimWindow) => number,
    nvim_win_get_height: (this: void, win: number | NeovimWindow) => number,
    nvim_get_current_win: (this: void) => NeovimWindow,
  },
  lsp: {
    get_client_by_id: (this: void, client_id: number) => NvimLspClient,
    inlay_hint: {
      enable: (this: void, enable: boolean, filter?: { bufnr?: number }) => void,
      is_enabled: (this: void) => void
    },
    buf: {
      format: (this: void, opts: { async?: boolean }) => void,
      code_action: (this: void) => void,
      references: (this: void) => void,
      signature_help: (this: void) => void,
      hover: (this: void) => void,
      implementation: (this: void) => void,
      type_definition: (this: void) => void,
      rename: (this: void) => void
    },
    protocol: {
      make_client_capabilities: (this: void) => VimLSPProtocolClientCapabilities
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
    del: (this: void, mode: string, bind: string) => boolean,
    set: (this: void, mode: string | string[], stroke: string, ...args: any[]) => void
  },
  ui: {
    input: (this: void, config: { prompt: string }, callback: (this: void, input?: string) => void) => void,
    open: (this: void, path: string) => {
      wait: (this: unknown) => void
    },
    select: VimUISelectFunction,
  },
  o: {
    cmdheight: number,
    fillchars: string,
    shell: string,
    shiftwidth: number,
    foldcolumn: string,
    foldlevel: number,
    foldlevelstart: number,
    foldenable: boolean,
    whichwrap: {
      append: (target: string) => string
    }
  },
  g: {
    terminal_emulator: string,
    mapleader: string,
  },
  highlight: {
    create: (this: void, id: string, args: Partial<{
      ctermbg: number,
      guifg: string,
      guibg: string
    }>, unknownArg: boolean) => void
  },
  fn: {
    systemlist: (this: void, command: string) => string[],
    feedkeys: (this: void, keys: string, mode: string) => void,
    // Returns -1 if a buffer is not currently in a window
    bufwinid: (this: void, buf: NeovimBuffer | number) => number,
    jobstart: (this: void, command: string, opts: VimFnJobStartOpts) => void,
    executable: (this: void, exe: string) => 0 | 1,
    getcwd: (this: void) => string,
    sign_define: (this: void, id: string, options: {
      text: string,
      texthl: 'red' | string,
      linehl: string,
      numhl: string,
    }) => void
    system: (this: void, args: string[]) => string,
    stdpath: (this: void, target: string) => string,
    input: (this: void, prompt: string, initialValue?: string, formatHint?: 'file' | 'directory') => string,
    expand: (this: void, input: string) => string,
    getreg: (this: void, register: string) => string,
    setreg: (this: void, register: string, value: string) => void,
    getpid: (this: void) => number,
    getwininfo: (this: void, window: NeovimWindow | number) => NvimWindowInfo[],
  } & ({
    [key: string]: (this: void, ...args: unknown[]) => unknown
  }),
  loop: {
    fs_stat: (this: void, path: string) => boolean,
    spawn: (this: void, exe: string, opts: {
      stdio?: [stdin: number, stdout: number, stderr: number],
      env?: Record<string, string>,
      cwd?: string,
      uid?: number,
      gid?: number,
      verbatim?: boolean,
      args?: string[],
      // If true, the child process will be detached from the parent process.
      // This makes it possible for the child process to continue running after the parent exits.
      detached?: boolean,
    }, processExitCallback: (this: void, code: number, signal: number) => void) => VimLoopSpawnHandle,
    getuid: (this: void) => number,
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
    relativenumber: boolean,
    signcolumn: 'number' | string,
    numberwidth: number,
    ruler: boolean
    diffopt: string
  }
}

declare var vim: VimAPI;
