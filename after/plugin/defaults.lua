local function configure(_)
  -- Set title to file name and vim icon
  vim.o.title = true
  vim.o.titlestring = "%F "

  -- Mouse
  vim.o.mousehide = true
  vim.o.mousescroll = "ver:1,hor:1"
  vim.opt.mouse = nil

  -- Search
  vim.o.hlsearch = true

  -- Enable relative number
  vim.opt.relativenumber = true


  -- Enable cursorline and cursorcolumn
  vim.o.cursorline = true
  vim.o.cursorcolumn = true
  vim.o.cursorlineopt = 'both'

  vim.o.guicursor = 'i-ci:hor1-iCursor,a:blinkon1'
  vim.o.completeopt = "menu,menuone,preview,noselect"

  -- text rendering
  vim.o.linebreak = true
  vim.o.scrolloff = 4
  vim.o.sidescrolloff = 8

  -- Identation
  vim.o.autoindent = true
  vim.o.shiftwidth = 2
  vim.o.tabstop = 2
  vim.o.shiftround = true
  vim.o.expandtab = true
  vim.o.softtabstop = 2
  vim.o.smarttab = true

  -- Folding
  vim.o.foldcolumn = "0"
  vim.o.foldlevel = 99
  vim.o.foldlevelstart = 99
  vim.o.foldenable = true
  vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
  vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

  -- Set keymap 'jk' for 'esc' in 'i' and 'v'
  vim.keymap.set({ 'i', 'v' }, 'jk', [[<C-\><C-n>]], { silent = true })

  -- Set keymap for better paste
  vim.keymap.set({ 'v', 'x' }, 'p', 'P', { silent = true })
  vim.keymap.set({ 'v', "x" }, 'P', 'p', { silent = true })

  -- Set keymaps for 'vsplit' and 'split'
  vim.keymap.set({ "n" }, "<leader>v", ":vsplit<CR>", { silent = true })
  vim.keymap.set({ "n" }, "<leader>h", ":split<CR>", { silent = true })

  -- vim.g.gruvbox_material_foreground = "original"
  -- vim.g.gruvbox_material_background = "hard"
  -- vim.g.gruvbox_material_disable_italic_comment = 1
  -- vim.g.gruvbox_material_better_performance = 1
  -- vim.g.gruvbox_material_enable_bold = 1
  -- vim.g.gruvbox_material_ui_contrast = "low"
  -- vim.g.gruvbox_material_dim_inactive_windows = 1
  -- vim.g.gruvbox_material_statusline_style = "original"
  -- vim.g.gruvbox_material_current_word = "italic"
  -- vim.cmd([[colorscheme gruvbox-material]])
  vim.cmd([[highlight normal guibg=NONE]])
  vim.cmd([[highlight EndOfBuffer guibg=NONE]])
  vim.cmd([[highlight SignColumn guibg=NONE]])
  vim.cmd([[highlight cursorline guibg=Black]])
  vim.cmd([[highlight cursorcolumn guibg=Black]])
  vim.cmd([[highlight cursorlinenr guibg=Black]])
  vim.cmd([[highlight cursorlinesign guibg=Black]])

  require("lualine").setup({
    options = {
      icons_enabled = true,
      -- theme = "gruvbox-material",
      component_separators = "|",
      section_separators = "",
    },
  })

  -- See `:help telescope` and `:help telescope.setup()`
  require('telescope').setup {
    defaults = {
      file_ignore_patterns = { "node_modules", ".git", ".min.js" },
      mappings = {
        i = {
          ['<C-u>'] = false,
          ['<C-d>'] = false,
        },
        n = {
          ["q"] = require("telescope.actions").close
        }
      },
    },
  }

  -- Enable telescope fzf native, if installed
  pcall(require('telescope').load_extension, 'fzf')

  -- See `:help telescope.builtin`
  vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
  vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
  vim.keymap.set('n', '<leader>/', function()
    -- You can pass additional configuration to telescope to change theme, layout, etc.
    require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
      winblend = 10,
      previewer = false,
    })
  end, { desc = '[/] Fuzzily search in current buffer' })

  vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
  vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
  vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
  vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
  vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
  vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
  vim.keymap.set("n", "<leader>sb", ":Telescope harpoon marks<CR>", { silent = true, desc = '[S]earch [B]ookmarks' })
  -- HARPOON
  vim.keymap.set({ "n" }, "<leader>b", ":lua require('harpoon.mark').add_file()<CR>", { silent = true })
  --- TELESCOPE
  require("telescope").load_extension('harpoon')
end

local configuration_group = vim.api.nvim_create_augroup("Configuration", { clear = true })
vim.api.nvim_create_autocmd("VimEnter", {
  callback = configure, group = configuration_group
})
