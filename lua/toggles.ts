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
  lspconfig: {
    // Activate builtin lsp_hints functionality on LSP server attach
    // Only works with nightly neovim ^0.10.0
    useInlayHints: true,
    inlayHints: {
      displayMode: 'only-in-normal-mode'
    }
  },
  useUFO: true,
  behaviour: {
    // !! UNSUPPORTED -- NOT IMPLEMENTED !!
    // Use 'gj' and 'gk' to navigate as expected
    wrappedLinesAsSeparateLines: true,
  }
} as const;
