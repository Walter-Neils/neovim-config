vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin" .. ":" .. vim.env.PATH

vim.opt.clipboard = "unnamedplus"
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.opt.signcolumn = "yes"
vim.o.exrc = true

require("config.keymaps")
require("config.lazy")
