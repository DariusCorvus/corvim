local api = vim.api
local keymap = api.nvim_buf_set_keymap

local function lsp_highlight_document(client)
	if client.server_capabilities.documentHighlightProvider then
		api.nvim_exec(
			[[
    augroup lsp_document_highlight
      autocmd! * <buffer>
      autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
      autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
    augroup END
    ]],
			false
		)
	end
end

local function lsp_keymaps(bufnr)
	local opt = { noremap = true, silent = true }
	local maps = {
		{ "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>" },
		{ "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>" },
		{ "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>" },
		{ "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>" },
		{ "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>" },
		{ "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>" },
		{ "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>" },
		{ "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>" },
		{ "n", "<leader><tab>", "<cmd>lua vim.diagnostic.open_float()<CR>" },
		{ "n", "[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>' },
		{ "n", "]d", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>' },
	}

	for _, map in ipairs(maps) do
		keymap(bufnr, map[1], map[2], map[3], opt)
	end
end

local M = {}
function M.on_attach(client, bufnr)
	lsp_keymaps(bufnr)
	lsp_highlight_document(client)
end
return M
