vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin" .. ":" .. vim.env.PATH

vim.opt.clipboard = "unnamedplus"
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.opt.signcolumn = "yes"
vim.o.exrc = true

vim.opt.listchars = {
  tab = "» ",
  trail = "·",
  nbsp = "␣",
  eol = "↲",
}

vim.opt.tabstop = 4      -- Number of spaces that a <Tab> in the file counts for
vim.opt.softtabstop = 4  -- Number of spaces that a <Tab> counts for while performing editing operations
vim.opt.shiftwidth = 4   -- Number of spaces to use for each step of (auto)indent
vim.opt.expandtab = true -- Convert tabs to spaces

require("config.keymaps")
require("config.lazy")
