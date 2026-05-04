return {
  {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    config = function()
      require("lsp_lines").setup()

      -- 1. Disable the default virtual_text (the text at the end of the line)
      -- 2. Enable lsp_lines' virtual_lines
      vim.diagnostic.config({
        virtual_text = false,
        virtual_lines = true, -- This now uses the plugin's logic
      })
    end,
  },
}
