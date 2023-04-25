-- Install packer
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	is_bootstrap = true
	vim.fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
	vim.cmd([[packadd packer.nvim]])
end

require("packer").startup(function(use)
	-- Package manager
	use("wbthomason/packer.nvim")

	use({
		-- LSP Configuration & Plugins
		"neovim/nvim-lspconfig",
		requires = {
			-- Automatically install LSPs to stdpath for neovim
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",

			-- Useful status updates for LSP
			"j-hui/fidget.nvim",

			-- Additional lua configuration, makes nvim stuff amazing
			"folke/neodev.nvim",
		},
	})

	use({
		-- Autocompletion
		"hrsh7th/nvim-cmp",
		requires = { "hrsh7th/cmp-nvim-lsp", "L3MON4D3/LuaSnip", "saadparwaiz1/cmp_luasnip" },
	})

	use({
		"ggandor/leap.nvim",
		requires = { "tpope/vim-repeat" },
		run = function()
			require("leap").opts.safe_labels = {}
		end,
	})

	use({
		-- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		run = function()
			pcall(require("nvim-treesitter.install").update({ with_sync = true }))
		end,
	})

	use({
		-- Additional text objects via treesitter
		"nvim-treesitter/nvim-treesitter-textobjects",
		after = "nvim-treesitter",
	})
	use({
		"dariuscorvus/tree-sitter-surrealdb.nvim",
		requires = { "nvim-treesitter" },
	})

	use({
		"dariuscorvus/tree-sitter-language-injection.nvim",
		requires = { "nvim-treesitter" },
	})

	-- Git related plugins
	use("tpope/vim-fugitive")
	use("tpope/vim-rhubarb")
	use("lewis6991/gitsigns.nvim")

	use("sainnhe/gruvbox-material")
	use("navarasu/onedark.nvim") -- Theme inspired by Atom
	use("nvim-lualine/lualine.nvim") -- Fancier statusline
	use("lukas-reineke/indent-blankline.nvim") -- Add indentation guides even on blank lines
	use("numToStr/Comment.nvim") -- "gc" to comment visual regions/lines
	use("tpope/vim-sleuth") -- Detect tabstop and shiftwidth automatically

	-- Fuzzy Finder (files, lsp, etc)
	use({ "nvim-telescope/telescope.nvim", branch = "0.1.x", requires = { "nvim-lua/plenary.nvim" } })

	-- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make", cond = vim.fn.executable("make") == 1 })

	-- Formatter & LSP
	use({ "jose-elias-alvarez/null-ls.nvim" })

	-- Autopairs
	use({
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	})

	-- Current Word
	use({ "dominikduda/vim_current_word" })

	-- Debugging
	use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } })

	-- Terminal
	use({
		"akinsho/toggleterm.nvim",
		tag = "*",
		config = function()
			require("toggleterm").setup({
				size = function(term)
					if term.direction == "horizontal" then
						return vim.fn.winheight(0) * 0.4
					elseif term.direction == "vertical" then
						return vim.o.columns * 0.4
					end
				end,
			})
		end,
	})

	-- Sessions
	use({
		"folke/persistence.nvim",
		event = "BufReadPre",
		module = "persistence",
		config = function()
			require("persistence").setup()
		end,
	})

	-- Add custom plugins to packer from ~/.config/nvim/lua/custom/plugins.lua
	local has_plugins, plugins = pcall(require, "custom.plugins")
	if has_plugins then
		plugins(use)
	end

	if is_bootstrap then
		require("packer").sync()
	end
end)

-- When we are bootstrapping a configuration, it doesn't
-- make sense to execute the rest of the init.lua.
--
-- You'll need to restart nvim, and then it will work.
if is_bootstrap then
	print("==================================")
	print("    Plugins are being installed")
	print("    Wait until Packer completes,")
	print("       then restart nvim")
	print("==================================")
	return
end

-- Automatically source and re-compile packer whenever you save this init.lua
local packer_group = vim.api.nvim_create_augroup("Packer", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
	command = "source <afile> | silent! LspStop | silent! LspStart | PackerCompile",
	group = packer_group,
	pattern = vim.fn.expand("$MYVIMRC"),
})

local M = {
	terminals = {},
}

-- [[ Setting options ]]
-- See `:help vim.o`
vim.o.title = true
vim.o.titlestring = "%F "

-- Set highlight on search
vim.o.hlsearch = true

-- Make line numbers default
vim.wo.number = true

-- Set relative line numbers
vim.o.relativenumber = true

-- Set cursor line visble
vim.o.cursorline = true
-- Set cursor column visible
vim.o.cursorcolumn = true

-- Enable mouse mode
vim.o.mouse = "a"

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = "yes"

vim.o.tabstop = 2
vim.o.shiftwidth = 2

vim.o.cmdheight = 0

vim.o.scrolloff = 8
vim.o.sidescrolloff = 8

-- Set colorscheme
vim.o.termguicolors = true
vim.g.gruvbox_material_foreground = "original"
vim.g.gruvbox_material_background = "hard"
vim.g.gruvbox_material_disable_italic_comment = 1
vim.g.gruvbox_material_better_performance = 1
vim.g.gruvbox_material_enable_bold = 1
vim.g.gruvbox_material_ui_contrast = "low"
vim.g.gruvbox_material_dim_inactive_windows = 1
vim.g.gruvbox_material_statusline_style = "original"
vim.g.gruvbox_material_current_word = "italic"
vim.cmd([[colorscheme gruvbox-material]])

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

-- Clipboard
vim.o.clipboard = "unnamed,unnamedplus"

-- [[ Basic Keymaps ]]
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local keymap_opt = { noremap = true, silent = true }

vim.keymap.set("n", "<leader>w", ":w<CR>", keymap_opt)
vim.keymap.set("n", "<leader>ww", ":w!<CR>", keymap_opt)

vim.keymap.set("n", "<leader>q", ":q<CR>", keymap_opt)
vim.keymap.set("n", "<leader>qq", ":q!<CR>", keymap_opt)
vim.keymap.set("n", "<leader>qa", ":qa<CR>", keymap_opt)
vim.keymap.set("n", "<leader>qqa", ":qa!<CR>", keymap_opt)

vim.keymap.set("n", "<leader>v", ":vsplit<CR>", keymap_opt)
vim.keymap.set("n", "<leader>h", ":split<CR>", keymap_opt)

vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", keymap_opt)
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", keymap_opt)

vim.keymap.set("n", "<TAB>", ">>", keymap_opt)
vim.keymap.set("n", "<S-TAB>", "<<", keymap_opt)

vim.keymap.set("i", "<A-j>", "<Esc>:m .+1<CR>==gi", keymap_opt)
vim.keymap.set("i", "<A-k>", "<Esc>:m .-2<CR>==gi", keymap_opt)

vim.keymap.set("i", "<S-TAB>", "<C-D>", keymap_opt)

vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", keymap_opt)
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", keymap_opt)

vim.keymap.set("v", "<TAB>", ">gv", keymap_opt)
vim.keymap.set("v", "<S-TAB>", "<gv", keymap_opt)

vim.keymap.set("i", "jk", [[<C-\><C-n>]], keymap_opt)
vim.keymap.set("v", "jk", [[<C-\><C-n>]], keymap_opt)

-- DAP keymaps
vim.keymap.set("n", "<F5>", function()
	require("dap").continue()
end)
vim.keymap.set("n", "<F10>", function()
	require("dap").step_over()
end)
vim.keymap.set("n", "<F11>", function()
	require("dap").step_into()
end)
vim.keymap.set("n", "<F12>", function()
	require("dap").step_back()
end)
vim.keymap.set("n", "<leader>b", function()
	require("dap").toggle_breakpoint()
end)
vim.keymap.set("n", "<leader>B", function()
	require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
end)
vim.keymap.set("n", "<leader>bl", function()
	require("dap").set_breakpoint(nil, nil, vim.fn.input("Logpoint message: "))
end)
vim.keymap.set("n", "<leader>dr", function()
	require("dap").repl.open()
end)
vim.keymap.set("n", "<leader>dl", function()
	require("dap").run_last()
end)

-- DAPUI
require("dapui").setup()
vim.keymap.set("n", "<leader><F5>", function()
	require("dapui").toggle()
end)

-- persistence keymaps
vim.keymap.set("n", "<leader>qs", function()
	require("persistence").load()
end)
vim.keymap.set("n", "<leader>ql", function()
	require("persistence").load({ last = true })
end)
vim.keymap.set("n", "<leader>qd", function()
	require("persistence").stop()
end)
-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

-- Enable leap.nvim
require("leap").add_default_mappings()

-- Set lualine as statusline
-- See `:help lualine.txt`
require("lualine").setup({
	options = {
		icons_enabled = false,
		theme = "gruvbox-material",
		component_separators = "|",
		section_separators = "",
	},
})

-- Enable Comment.nvim
require("Comment").setup()

-- Enable `lukas-reineke/indent-blankline.nvim`
-- See `:help indent_blankline.txt`
require("indent_blankline").setup({
	char = "⎸",
	show_trailing_blankline_indent = false,
})

-- Gitsigns
-- See `:help gitsigns.txt`
require("gitsigns").setup({
	signs = {
		add = { text = "+" },
		change = { text = "~" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
	},
})

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require("telescope").setup({
	file_ignore_patterns = { "node_modules", "__pycache__" },
	defaults = {
		mappings = {
			i = {
				["<C-u>"] = false,
				["<C-d>"] = false,
			},
		},
		vimgrep_arguments = {
			"rg",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
			"--ignore-file",
			".gitignore",
		},
	},
})

-- Enable telescope fzf native, if installed
pcall(require("telescope").load_extension, "fzf")

-- See `:help telescope.builtin`
vim.keymap.set("n", "<leader>?", require("telescope.builtin").oldfiles, { desc = "[?] Find recently opened files" })
vim.keymap.set("n", "<leader><space>", require("telescope.builtin").buffers, { desc = "[ ] Find existing buffers" })
vim.keymap.set("n", "<leader>/", function()
	-- You can pass additional configuration to telescope to change theme, layout, etc.
	require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		winblend = 10,
		previewer = false,
	}))
end, { desc = "[/] Fuzzily search in current buffer]" })

vim.keymap.set("n", "<leader>sf", require("telescope.builtin").find_files, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>sh", require("telescope.builtin").help_tags, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sw", require("telescope.builtin").grep_string, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>sg", require("telescope.builtin").live_grep, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sd", require("telescope.builtin").diagnostics, { desc = "[S]earch [D]iagnostics" })

-- [[ Configure Treesitter ]]
---- Treesitter SURQL
require("tree-sitter-surrealdb").setup()

---- Treesitter language injections
require("tree-sitter-language-injection").setup()

-- See `:help nvim-treesitter`
require("nvim-treesitter.configs").setup({
	-- Add languages to be installed here that you want installed for treesitter
	ensure_installed = { "c", "cpp", "go", "lua", "python", "rust", "typescript", "help", "vim" },
	highlight = { enable = true },
	indent = { enable = true, disable = { "python" } },
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<c-space>",
			node_incremental = "<c-space>",
			scope_incremental = "<c-s>",
			node_decremental = "<c-backspace>",
		},
	},
	textobjects = {
		select = {
			enable = true,
			lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
			keymaps = {
				-- You can use the capture groups defined in textobjects.scm
				["aa"] = "@parameter.outer",
				["ia"] = "@parameter.inner",
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
			},
		},
		move = {
			enable = true,
			set_jumps = true, -- whether to set jumps in the jumplist
			goto_next_start = {
				["]m"] = "@function.outer",
				["]]"] = "@class.outer",
			},
			goto_next_end = {
				["]M"] = "@function.outer",
				["]["] = "@class.outer",
			},
			goto_previous_start = {
				["[m"] = "@function.outer",
				["[["] = "@class.outer",
			},
			goto_previous_end = {
				["[M"] = "@function.outer",
				["[]"] = "@class.outer",
			},
		},
		swap = {
			enable = true,
			swap_next = {
				["<leader>a"] = "@parameter.inner",
			},
			swap_previous = {
				["<leader>A"] = "@parameter.inner",
			},
		},
	},
})

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)

-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
	-- NOTE: Remember that lua is a real programming language, and as such it is possible
	-- to define small helper and utility functions so you don't have to repeat yourself
	-- many times.
	--
	-- In this case, we create a function that lets us more easily define mappings specific
	-- for LSP related items. It sets the mode, buffer and description for us each time.
	local nmap = function(keys, func, desc)
		if desc then
			desc = "LSP: " .. desc
		end

		vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
	end

	nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
	nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

	nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
	nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
	nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
	nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
	nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
	nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

	-- See `:help K` for why this keymap
	nmap("K", vim.lsp.buf.hover, "Hover Documentation")
	nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

	-- Lesser used LSP functionality
	nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
	nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
	nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
	nmap("<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, "[W]orkspace [L]ist Folders")

	-- Create a command `:Format` local to the LSP buffer
	vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
		vim.lsp.buf.format()
	end, { desc = "Format current buffer with LSP" })
end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
	-- clangd = {},
	-- gopls = {},
	-- pyright = {},
	-- rust_analyzer = {},
	-- tsserver = {},

	lua_ls = {
		Lua = {
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
		},
	},
}

-- Setup neovim lua configuration
require("neodev").setup()
--
-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- Setup mason so it can manage external tooling
require("mason").setup()

-- Ensure the servers above are installed
local mason_lspconfig = require("mason-lspconfig")

mason_lspconfig.setup({
	ensure_installed = vim.tbl_keys(servers),
})

mason_lspconfig.setup_handlers({
	function(server_name)
		-- vim.notify(server_name)
		require("lspconfig")[server_name].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = servers[server_name],
		})
	end,
})

-- Turn on lsp status information
require("fidget").setup()

-- nvim-cmp setup
local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
	},
})

local null_ls = require("null-ls")
local mason_registry = require("mason-registry")
local packages = mason_registry.get_installed_packages()

local function contains(tab, val)
	for _, value in ipairs(tab) do
		if value == val then
			return true
		end
	end

	return false
end

local formatters = {}
for _, value in ipairs(packages) do
	if contains(value["spec"]["categories"], "Formatter") then
		local name = value["spec"]["name"]
		if name == "sql-formatter" then
			name = "sql_formatter"
		end
		if name == "clang-format" then
			name = "clang_format"
		end
		formatters[name] = true
	end
end

local null_ls_sources = {}
for key, _ in pairs(formatters) do
	local builtin = null_ls.builtins.formatting[key]
	table.insert(null_ls_sources, builtin)
end

local lsp_formatting = function(bufnr)
	vim.lsp.buf.format({
		filter = function(client)
			return client.name == "null-ls"
		end,
		bufnr = bufnr,
	})
end

local augroup_formatting = vim.api.nvim_create_augroup("LspFormatting", {})

local null_ls_on_attach = function(client, bufnr)
	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_clear_autocmds({ group = augroup_formatting, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = augroup_formatting,
			buffer = bufnr,
			callback = function()
				lsp_formatting(bufnr)
			end,
		})
	end
end

null_ls.setup({
	sources = null_ls_sources,
	on_attach = null_ls_on_attach,
})

-- Debugger
local function job(command)
	local paths = {}
	local job_id = vim.fn.jobstart(command, {
		on_stdout = function(_, data, _)
			table.insert(paths, vim.fn.join(data))
		end,
	})

	vim.fn.jobwait({ job_id })
	return paths[1]
end

local function get_python()
	local cwd = vim.fn.getcwd()
	if jit.os == "Windows" then
		if vim.fn.executable(cwd .. "/venv/Scripts/python.exe") == 1 then
			return cwd .. "/venv/Scripts/python.exe"
		elseif vim.fn.executable(cwd .. "/.venv/Scripts/python.exe") == 1 then
			return cwd .. "/.venv/Scripts/python.exe"
		else
			return job("which.exe python.exe")
		end
	end
	if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
		return cwd .. "/venv/bin/python"
	elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
		return cwd .. "/.venv/bin/python"
	else
		return "/usr/bin/python"
	end
end

local function get_debugpy()
	if jit.os == "Windows" then
		return vim.fn.getenv("USERPROFILE") .. "/AppData/Local/nvim-data/mason/packages/debugpy/venv/Scripts/python.exe"
	end
	return vim.fn.getenv("HOME") .. "/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
end

local dap = require("dap")
dap.defaults.fallback.terminal_win_cmd = "tabnew"

dap.adapters.python = {
	type = "executable",
	command = get_debugpy(),
	args = { "-m", "debugpy.adapter" },
}
dap.configurations.python = {
	{
		type = "python",
		request = "launch",
		name = "Launch file",
		program = "${file}",
		pythonPath = get_python(),
	},
}

-- Terminal
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

function _G.toggle_terminal(name, direction)
	if direction == nil then
		direction = "float"
	end
	if name == nil then
		terminal.direction = direction
		terminal:toggle()
		return
	end

	M.terminals[name].direction = direction
	M.terminals[name]:toggle()
end

function M.add_terminal(name, cmd, direction)
	if name == nil then
		return
	end

	if direction == nil then
		direction = "float"
	end

	if cmd == nil then
		M.terminals[name] = base_terminal:new({ direction = direction })
		return
	end
	M.terminals[name] = base_terminal:new({ cmd = cmd, direction = direction })
end

-- Terminal
local function detect_shell()
	if jit.os == "Windows" then
		if vim.fn.executable("pwsh") then
			return "pwsh -nol"
		end
	end
	return vim.o.shell
end

M.add_terminal("shell", detect_shell())
vim.keymap.set("n", "<leader>tf", "<cmd>lua toggle_terminal('shell')<CR>", keymap_opt)
vim.keymap.set("n", "<leader>tt", "<cmd>lua toggle_terminal('shell', 'tab')<CR>", keymap_opt)
vim.keymap.set("n", "<leader>tv", "<cmd>lua toggle_terminal('shell', 'vertical')<CR>", keymap_opt)
vim.keymap.set("n", "<leader>th", "<cmd>lua toggle_terminal('shell', 'horizontal')<CR>", keymap_opt)

if vim.fn.executable("lazygit") then
	M.add_terminal("lazygit", "lazygit")

	vim.keymap.set("n", "<leader>tg", "<cmd>lua toggle_terminal('lazygit')<CR>", keymap_opt)
	vim.keymap.set("n", "<leader>tgt", "<cmd>lua toggle_terminal('lazygit', 'tab')<CR>", keymap_opt)
end

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
