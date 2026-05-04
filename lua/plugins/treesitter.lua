return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  opts = {
    highlight = { enable = true },
    indent = { enable = true },
    ensure_installed = {
      "bash", "c", "html", "javascript", "json", "lua", "luadoc",
      "markdown", "markdown_inline", "python", "query", "regex",
      "vim", "vimdoc", "yaml",
    },
  },
  config = function(_, opts)
    require("nvim-treesitter.config").setup(opts)
  end,
}
