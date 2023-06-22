return {
  "kevinhwang91/nvim-ufo",
  event = { "BufReadPre" },
  wants = { "promise-async" },
  dependencies = { "kevinhwang91/promise-async" },
  config = function()
    require("ufo").setup {}
    vim.keymap.set("n", "zR", require("ufo").openAllFolds)
    vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
  end,
}
