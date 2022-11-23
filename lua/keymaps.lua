local opts = { noremap = true, silent = true }
local g = vim.g
local keymap = vim.api.nvim_set_keymap

keymap("", "<Space>", "<Nop>", opts)
g.mapleader = " "
g.maplocalleader = " "

keymap("n", "<leader>e", ":NvimTreeFocus<CR>", opts)
keymap("n", "<leader>xe", ":NvimTreeClose<CR>", opts)
local ok, toggleterm = pcall(require, "config/toggleterm")
if ok then
	toggleterm.add_terminal("pwsh", "pwsh -NoLogo")
	toggleterm.add_terminal("lazygit", "lazygit")

	keymap("n", "<leader>t", "<cmd>lua Toggle_terminal('pwsh')<CR>", opts)
	keymap("n", "<leader>tg", "<cmd>lua Toggle_terminal('lazygit')<CR>", opts)
end
