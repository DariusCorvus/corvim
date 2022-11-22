local colorscheme = "gruvbox-material"

if colorscheme == "gruvbox-material" then
  vim.g.gruvbox_material_foreground = "original"
  vim.g.gruvbox_material_background = "hard"
  vim.g.gruvbox_material_disable_italic_comment = 1
  vim.g.gruvbox_material_better_performance = 1
  vim.g.gruvbox_material_enable_bold = 1
  vim.g.gruvbox_material_ui_contrast = 'high'
end

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)

if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end
