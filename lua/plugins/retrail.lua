return {
  "kaplanz/nvim-retrail",
  init = function()
    local opts = require "configs.retrail"
    require("retrail").setup(opts)
  end,
}
