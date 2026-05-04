return {
	"saghen/blink.cmp",
	version = "v0.*", -- Use a release tag to ensure stability
	opts = {
		-- 'default' for modular config, 'super-tab' for a vscode-like feel
		keymap = {
			preset = "default",
			["<Tab>"] = { "select_next", "fallback" },
			["<S-Tab>"] = { "select_prev", "fallback" },
			["<CR>"] = { "accept", "fallback" },
		},

		appearance = {
			use_nvim_cmp_as_default = true,
			nerd_font_variant = "mono",
		},

		-- Default sources for autocomplete
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
		},
	},
}
