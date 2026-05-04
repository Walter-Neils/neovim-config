return {
	{
		"nvimdev/lspsaga.nvim",
		event = "LspAttach",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
		opts = {
			hover = {
				max_width = 0.8,
				open_link = "gx",
				open_cmd = "!xdg-open", -- Or "!open" on macOS
			},
			ui = {
				border = "rounded",
				code_action = "💡", -- Shows a lightbulb when a fix is available
			},
			signature_help = {
				buffer_local_keybinds = {
					-- Allows you to cycle through multiple signatures if a function is overloaded
					next_sig = '<C-j>',
					previous_sig = '<C-k>',
				},
			},
			-- This is the key setting for Lspsaga's signature help behavior
			implement = {
				enable = true,
			},
		},
		keys = {
			{ "K", "<cmd>Lspsaga hover_doc<cr>", desc = "Hover Documentation" },
			-- You can also peek definitions in a floating window
			{ "gp", "<cmd>Lspsaga peek_definition<cr>", desc = "Peek Definition" },
		},
	},
}
