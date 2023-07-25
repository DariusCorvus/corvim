local function configure(_)
  -- Windows Defaults
  if jit.os == 'Windows' then 
    -- shell
    vim.o.shell = 'pwsh'
    vim.o.shellcmdflag = "-NoLogo -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();$PSDefaultParameterValues.Add('Out-File:Encoding', 'utf8');"
    vim.o.shellredir = '2>&1 | %%{ "$_" } | Out-File %s; exit $LastExitCode'
    vim.o.shellpipe = '2>&1 | %%{ "$_" } | Tee-Object %s; exit $LastExitCode'
  end

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
  vim.keymap.set({ "n" }, "<leader>v", ":vsplit<CR>", { desc = '[V]ertical Split', silent = true })
  vim.keymap.set({ "n" }, "<leader>h", ":split<CR>", { desc = '[H]orizontal Split', silent = true })

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
  vim.cmd([[highlight normal guibg=NONE]])
  vim.cmd([[highlight EndOfBuffer guibg=NONE]])
  vim.cmd([[highlight SignColumn guibg=NONE]])
  vim.cmd([[highlight cursorline guibg=Black]])
  vim.cmd([[highlight cursorcolumn guibg=Black]])
  vim.cmd([[highlight cursorlinenr guibg=Black]])
  vim.cmd([[highlight cursorlinesign guibg=Black]])
  vim.cmd([[highlight Visual guibg=gray]])

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

  -- TREESITTER
  require('nvim-treesitter.configs').setup {
    playground = {
      enable = true,
      disable = {},
      updatetime = 25,
      persist_queries = false,
      keybindings = {
        toggle_query_editor = 'o',
        toggle_hl_groups = 'i',
        toggle_injected_languages = 't',
        toggle_anonymous_nodes = 'a',
        toggle_language_display = 'I',
        focus_language = 'f',
        unfocus_language = 'F',
        update = 'R',
        goto_node = '<cr>',
        show_help = '?',
      }
    },
    -- Add languages to be installed here that you want installed for treesitter
    ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'typescript', 'vimdoc', 'vim' },

    -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
    auto_install = false,

    highlight = { enable = true, additional_vim_regex_highlighting = { "php", "css", "html" } },
    indent = { enable = false, disable = { 'python' } },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<c-space>',
        node_incremental = '<c-space>',
        scope_incremental = '<c-s>',
        node_decremental = '<M-space>',
      },
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ['aa'] = '@parameter.outer',
          ['ia'] = '@parameter.inner',
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['ac'] = '@class.outer',
          ['ic'] = '@class.inner',
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          [']m'] = '@function.outer',
          [']]'] = '@class.outer',
        },
        goto_next_end = {
          [']M'] = '@function.outer',
          [']['] = '@class.outer',
        },
        goto_previous_start = {
          ['[m'] = '@function.outer',
          ['[['] = '@class.outer',
        },
        goto_previous_end = {
          ['[M'] = '@function.outer',
          ['[]'] = '@class.outer',
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ['<leader>a'] = '@parameter.inner',
        },
        swap_previous = {
          ['<leader>A'] = '@parameter.inner',
        },
      },
    },
  }

  -- TREESITTER LANGUAGE INJECTION
  require("tree-sitter-language-injection").setup()

  local indent_group = vim.api.nvim_create_augroup("Identation", { clear = true })
  vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter", "FileType" }, {
    callback = function()
      vim.cmd([[set softtabstop=2 shiftwidth=2 tabstop=2 expandtab]])

      vim.cmd([[setlocal softtabstop=2 shiftwidth=2 tabstop=2 expandtab]])
    end,
    group = indent_group,
    pattern = "*"
  })
end

local configuration_group = vim.api.nvim_create_augroup("Configuration", { clear = true })
vim.api.nvim_create_autocmd("VimEnter", {
  callback = configure,
  group = configuration_group
})

vim.cmd([[set softtabstop=2 shiftwidth=2 tabstop=2 expandtab]])
