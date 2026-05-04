return {
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl", -- The entry point for the plugin
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      indent = {
        char = "▎", -- You can use "│", "┆", "┊", etc.
        tab_char = "▎",
      },
      scope = {
        enabled = true, -- Highlights the current code block
        show_start = false,
        show_end = false,
      },
      exclude = {
        filetypes = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
        },
      },
    },
  },
}
