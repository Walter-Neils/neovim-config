type VIMDiagnosticConfig = {
  update_in_insert: boolean,
  virtual_text: boolean
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

type VimLoopSpawnHandle = {
  close: (this: VimLoopSpawnHandle) => void,
  kill: (this: VimLoopSpawnHandle, signum?: number) => void,
};

type NeovimBuffer = unknown;
type NeovimWindow = unknown;

type VimAutocmdEvent = 'BufAdd' | 'BufDelete' | 'BufEnter' | 'BufFilePost' | 'BufFilePre' | 'BufHidden' | 'BufLeave' | 'BufModifiedSet' | 'BufNew' | 'BufNewFile' | 'BufRead' | 'BufReadCmd' | 'BufReadPre' | 'BufUnload' | 'BufWinEnter' | 'BufWinLeave' | 'BufWipeout' | 'BufWrite' | 'BufWriteCmd' | 'BufWritePost' | 'ChanInfo' | 'ChanOpen' | 'CmdUndefined' | 'CmdlineChanged' | 'CmdlineEnter' | 'CmdlineLeave' | 'CmdwinEnter' | 'CmdwinLeave' | 'ColorScheme' | 'ColorSchemePre' | 'CompleteChanged' | 'CompleteDonePre' | 'CompleteDone' | 'CursorHold' | 'CursorHoldI' | 'CursorMoved' | 'CursorMovedI' | 'DiffUpdated' | 'DirChanged' | 'DirChangedPre' | 'ExitPre' | 'FileAppendCmd' | 'FileAppendPost' | 'FileAppendPre' | 'FileChangedRO' | 'FileChangedShell' | 'FileChangedShellPost' | 'FileReadCmd' | 'FileReadPost' | 'FileReadPre' | 'FileType' | 'FileWriteCmd' | 'FileWritePost' | 'FileWritePre' | 'FilterReadPost' | 'FilterReadPre' | 'FilterWritePost' | 'FilterWritePre' | 'FocusGained' | 'FocusLost' | 'FuncUndefined' | 'UIEnter' | 'UILeave' | 'InsertChange' | 'InsertCharPre' | 'InsertEnter' | 'InsertLeavePre' | 'InsertLeave' | 'MenuPopup' | 'ModeChanged' | 'OptionSet' | 'QuickFixCmdPre' | 'QuickFixCmdPost' | 'QuitPre' | 'RemoteReply' | 'SearchWrapped' | 'RecordingEnter' | 'RecordingLeave' | 'SafeState' | 'SessionLoadPost' | 'SessionWritePost' | 'ShellCmdPost' | 'Signal' | 'ShellFilterPost' | 'SourcePre' | 'SourcePost' | 'SourceCmd' | 'SpellFileMissing' | 'StdinReadPost' | 'StdinReadPre' | 'SwapExists' | 'Syntax' | 'TabEnter' | 'TabLeave' | 'TabNew' | 'TabNewEntered' | 'TabClosed' | 'TermOpen' | 'TermEnter' | 'TermLeave' | 'TermClose' | 'TermRequest' | 'TermResponse' | 'TextChanged' | 'TextChangedI' | 'TextChangedP' | 'TextChangedT' | 'TextYankPost' | 'User' | 'UserGettingBored' | 'VimEnter' | 'VimLeave' | 'VimLeavePre' | 'VimResized' | 'VimResume' | 'VimSuspend' | 'WinClosed' | 'WinEnter' | 'WinLeave' | 'WinNew' | 'WinScrolled' | 'WinResized';

type VimAPI = {
  cmd: (this: void, params: string) => void,
  notify: (this: void, value: string | [string, string], level?: VimAPI["log"]["levels"][keyof VimAPI["log"]["levels"]]) => void,
  print: (this: void, value: any) => void,
  schedule: (this: void, callback: (this: void) => void) => void,
  defer_fn: (this: void, callback: (this: void) => void, ms: number) => void,
  json: {
    encode: (this: void, value: unknown) => string,
    decode: (this: void, value: string) => unknown
  },
  v: {
    shell_error: number
  },
  log: {
    levels: {
      INFO: Symbol,
      WARN: Symbol,
      ERROR: Symbol
    }
  },
  api: {
    nvim_set_hl: (this: void, arg1: number, arg2: string, params: VimHLColorParams) => void,
    nvim_create_user_command: (this: void, commandName: string, luaFunc: (this: void, args: { fargs: string[] }) => void, options: {
      nargs?: number | '+' | '*',
      bang?: boolean
    }) => void,
    nvim_create_autocmd: (this: void, eventName: VimAutocmdEvent, config: {
      group?: string,
      callback: (this: void) => void
    }) => void,
    nvim_win_get_cursor: (this: void, arg1: number) => number[],
    nvim_get_current_buf: (this: void) => NeovimBuffer,
    nvim_get_current_window: (this: void) => NeovimWindow,
    nvim_create_buf: (this: void, arg1: boolean, arg2: boolean) => NeovimBuffer,
    nvim_buf_set_option: (this: void, buffer: NeovimBuffer, ev: Lowercase<VimAutocmdEvent>, action: string) => void,
    nvim_set_option_value: (this: void, name: string, value: unknown, opts: {
      scope?: 'global' | 'local',
      win?: number,
      buf?: number
    }) => void
  },
  lsp: {
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
    set: (this: void, mode: 'i' | 'n' | 'a' | 't' | 'v' | 'x', stroke: string, ...args: any[]) => void
  },
  ui: {
    input: (this: void, config: { prompt: string }, callback: (this: void, input: string) => void) => void
  },
  o: {
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
    executable: (this: void, exe: string) => boolean,
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
    getpid: (this: void) => number
  },
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
    }, processExitCallback: (this: void, code: number, signal: number) => void) => VimLoopSpawnHandle
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
  }
}

declare var vim: VimAPI;
