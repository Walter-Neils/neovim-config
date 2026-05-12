local map = vim.keymap.set; -- Movement Keys
(function()
	local keys = { h = "<Left>", j = "<Down>", k = "<Up>", l = "<Right>" }
	for key, _ in pairs(keys) do
		map("n", "<C-" .. key .. ">", "<C-w>" .. key, {})
	end
	for key, move in pairs(keys) do
		map("i", "<C-" .. key .. ">", move, { desc = "Move cursor in insert mode" })
	end
end)()

map("n", "<C-n>", ":NvimTreeToggle<CR>", { desc = "Open File Explorer" })

vim.keymap.set("n", "<leader>fm", function()
	require("conform").format({ bufnr = vim.api.nvim_get_current_buf() })
	-- vim.lsp.buf.format({async = true})
end)

-- vim.api.nvim_create_autocmd("LspAttach", {
-- 	callback = function(ev)
-- 		end, { buffer = ev.buf })
-- 	end
-- })

vim.keymap.set("", "<Leader>i", function()
	local already_active = vim.lsp.inlay_hint.is_enabled()
	vim.lsp.inlay_hint.enable(not already_active)
	vim.diagnostic.config({ virtual_lines = not already_active })
end, { desc = "Toggle lsp_lines" })

vim.keymap.set({ "n", "x" }, "<leader>ca", function()
	require("tiny-code-action").code_action()
end, { noremap = true, silent = true })

map({ "n", "x", "t" }, "<A-i>", function()
	vim.cmd("ToggleTerm cmd=tmux")
end, { noremap = true, silent = true })

vim.keymap.set(
	"i",
	"<C-i>",
	"<cmd>Lspsaga signature_help<CR>",
	{ desc = "Signature Help", buffer = vim.api.nvim_get_current_buf() }
)

vim.keymap.set({ "n", "v" }, "<leader>/", "gcc", { remap = true, desc = "Toggle comment" })

-- Glance binds
map({ "n" }, "<leader>glr", "<cmd>Glance references<CR>", { silent = true })
map({ "n" }, "<leader>gld", "<cmd>Glance definitions<CR>", { silent = true })
map({ "n" }, "<leader>gltd", "<cmd>Glance type_definitions<CR>", { silent = true })
map({ "n" }, "<leader>gli", "<cmd>Glance implementations<CR>", { silent = true })

-- Buffer binds
map({ "n" }, "<leader>x", "<cmd>BufferClose<CR>", { noremap = true, silent = true })

map({ "n" }, "<leader>s", "<cmd>vsplit<CR>", { silent = true })
map({ "n" }, "<Tab>", "<cmd>BufferNext<CR>", { silent = true })
map({ "n" }, "<A-l>", "<cmd>BufferNext<CR>", { silent = true })
map({ "n" }, "<A-h>", "<cmd>BufferPrevious<CR>", { silent = true })

map({ "n", "i" }, "<F2>", vim.lsp.buf.rename, { silent = false })
