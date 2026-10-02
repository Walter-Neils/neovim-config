vim.o.foldcolumn = '1' -- '0' is not bad
vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true


return {
  {
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "kevinhwang91/promise-async",
    },
    event = "BufReadPost",
    opts = {
      provider_selector = function(bufnr, filetype, buftype)
        -- Fallback to treesitter, then indent provider if LSP is unavailable
        return { "treesitter", "indent" }
      end,
    },
    config = function(_, opts)
      -- Keymaps to open/close all folds
      vim.keymap.set("n", "zR", require("ufo").openAllFolds, { desc = "Open all folds" })
      vim.keymap.set("n", "zM", require("ufo").closeAllFolds, { desc = "Close all folds" })
      vim.keymap.set("n", "zr", require("ufo").openFoldsExceptKinds, { desc = "Open folds except kinds" })
      vim.keymap.set("n", "zm", require("ufo").closeFoldsWith, { desc = "Close folds with" })

      require("ufo").setup(opts)
    end,
  },
}
