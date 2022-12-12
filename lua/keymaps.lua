local opts = { noremap = true, silent = true }
local g = vim.g
local keymap = vim.api.nvim_set_keymap

keymap("", "<Space>", "<Nop>", opts)
g.mapleader = " "
g.maplocalleader = " "

keymap("n", "<leader>e", ":NvimTreeFocus<CR>", opts)
keymap("n", "<leader>xe", ":NvimTreeClose<CR>", opts)
keymap("n", "<leader>w", ":w<CR>", opts)
keymap("n", "<leader>ww", ":w!<CR>", opts)
keymap("n", "<leader>q", ":q<CR>", opts)
keymap("n", "<leader>qa", ":qa<CR>", opts)
keymap("n", "<leader>qq", ":q!<CR>", opts)
keymap("n", "<leader>qqa", ":qa!<CR>", opts)
keymap("n", "<leader>v", ":vsplit<CR>", opts)
keymap("n", "<leader>h", ":split<CR>", opts)

local ok, telescope = pcall(require, "telescope")
if ok then
	local builtin = require("telescope.builtin")
	keymap("n", "<leader>ff", "<cmd>:Telescope find_files<CR>", {})
	keymap("n", "<leader>fg", "<cmd>:Telescope live_grep<CR>", {})
	keymap("n", "<leader>fb", "<cmd>:Telescope buffers<CR>", {})
	keymap("n", "<leader>fn", "<cmd>:Telescope help_tags<CR>", {})
end

local ok, toggleterm = pcall(require, "config/toggleterm")
if ok then
	toggleterm.add_terminal("pwsh", "pwsh -NoLogo")
	toggleterm.add_terminal("lazygit", "lazygit")

	keymap("n", "<leader>t", "<cmd>lua Toggle_terminal('pwsh')<CR>", opts)
	keymap("n", "<leader>tg", "<cmd>lua Toggle_terminal('lazygit')<CR>", opts)
end

