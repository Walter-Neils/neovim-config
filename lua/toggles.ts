export const CONFIGURATION = {
  useLSPLines: false,
  useCMP: true,
  useTelescope: true,
  useLSPUI: false,
  useRustaceanvim: true,
  useLSPSignature: true,
  useIndentBlankline: true,
  useTreeDevIcons: true,
  useLualine: true,
  useBarBar: false,
  lspconfig: {
    // Activate builtin lsp_hints functionality on LSP server attach
    useInlayHints: false
  }
} as const;
