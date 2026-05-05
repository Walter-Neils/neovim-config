local nord = {
	"shaunsingh/nord.nvim",
	name = "Nord",
	priority = 1000,
	config = function()
		vim.cmd.colorscheme "nord"
	end
}
local catppuccin = {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000, -- Load this first
	config = function()
		vim.cmd.colorscheme "catppuccin"
	end
}

return catppuccin
