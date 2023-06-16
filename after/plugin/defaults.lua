-- Set title to file name and vim icon
vim.o.title = true
vim.o.titlestring = "%F "

-- Enable relative number
vim.opt.relativenumber = true

-- Enable scrollbar
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8

-- Enable cursorline and cursorcolumn
vim.o.cursorline = true
vim.o.cursorcolumn = true
vim.o.cursorlineopt = 'both'

vim.o.guicursor = 'i-ci:hor1-iCursor,a:blinkon1'

-- Set keymap 'jk' for 'esc' in 'i' and 'v'
vim.keymap.set({ 'i', 'v' }, 'jk', [[<C-\><C-n>]], { silent = true })

-- Set keymaps for 'vsplit' and 'split'
vim.keymap.set({ "n" }, "<leader>v", ":vsplit<CR>", { silent = true })
vim.keymap.set({ "n" }, "<leader>h", ":split<CR>", { silent = true })

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

-- HARPOON
vim.keymap.set({ "n" }, "<leader>sb", ":Telescope harpoon marks<CR>", { silent = true })
vim.keymap.set({ "n" }, "<leader>b", ":lua require('harpoon.mark').add_file()<CR>", { silent = true })
--- TELESCOPE
require("telescope").load_extension('harpoon')
