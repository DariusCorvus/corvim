require("nvim-treesitter.configs").setup({
	highlight = { enable = true },
	indent = { enable = false },
	autotag = { enable = true },
	context_commentstring = {
		enable = true,
		enable_autocmd = true,
	},
})

require("treesitter-context")
