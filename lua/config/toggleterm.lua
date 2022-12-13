local status_ok, toggleterm = pcall(require, "toggleterm")

if not status_ok then
	return
end

local M = {
	terminals = {},
	config = {
		size = function(term)
			if term.direction == "horizontal" then
				return vim.fn.winheight(0) * 0.4
			elseif term.direction == "vertical" then
				return vim.o.columns * 0.4
			end
		end,
	},
}

toggleterm.setup(M.config)

function _G.set_terminal_keymaps()
	local opts = { noremap = true }
	vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], opts)
	vim.api.nvim_buf_set_keymap(0, "t", "jk", [[<C-\><C-n>]], opts)
	vim.api.nvim_buf_set_keymap(0, "t", "<C-h>", [[<C-\><C-W>h]], opts)
	vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<C-\><C-W>j]], opts)
	vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C-\><C-W>k]], opts)
	vim.api.nvim_buf_set_keymap(0, "t", "<C-l>", [[<C-\><C-W>l]], opts)
end
vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

local base_terminal = require("toggleterm.terminal").Terminal
local terminal = base_terminal:new({ hidden = true })

function Toggle_terminal(name)
	if name == nil then
		terminal:toggle()
		return
	end

	M.terminals[name]:toggle()
end

local function add_terminal(name, cmd, direction)
	if name == nil or cmd == nil then
		return
	end

	if direction == nil then
		direction = "float"
	end

	M.terminals[name] = base_terminal:new({
		cmd = cmd,
		hidden = true,
		direction = direction,
	})
end

M.add_terminal = add_terminal

return M
