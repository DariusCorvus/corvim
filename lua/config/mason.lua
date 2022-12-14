require("mason").setup()
local mason_lspconfig = require("mason-lspconfig")
local lspconfig = require("lspconfig")
local lsp = require("config/lsp")

mason_lspconfig.setup()
mason_lspconfig.setup_handlers({
	function(server_name)
		lspconfig[server_name].setup({ on_attach = lsp.on_attach })
	end,
})
