export const CONFIGURATION = {
  // Kinda buggy, but really nice when it's working
  useLSPLines: false,
  useCMP: true,
  useTelescope: true,
  useLSPUI: false,
  useRustaceanvim: true,
  useLSPSignature: true,
  useIndentBlankline: true,
  useTreeDevIcons: true,
  useLualine: true,
  useBarBar: true,
  useComments: true,
  useMarks: true,
  useTrouble: true,
  mason: {
    defaultInstalled: ['typescript-language-server', 'clangd', 'lua-language-server'] as const
  },
  lspconfig: {
    // Activate builtin lsp_hints functionality on LSP server attach
    // Only works with nightly neovim ^0.10.0
    useInlayHints: true,
    inlayHints: {
      displayMode: 'only-in-normal-mode'
    },
    configuredLSPServers: ['tsserver', 'lua_ls', 'clangd'] as const,
    rename: {
      enabled: true,
      bind: "<F2>"
    }
  },
  useUFO: true,
  behaviour: {
    // !! UNSUPPORTED -- NOT IMPLEMENTED !!
    // Use 'gj' and 'gk' to navigate as expected
    wrappedLinesAsSeparateLines: true,
  },
  customCommands: {
    fixRustAnalyzer: {
      enabled: true
    },
    installDefaultLSPServers: {
      enabled: true
    },
    resetInstall: {
      enabled: false
    },
  }
} as const;
