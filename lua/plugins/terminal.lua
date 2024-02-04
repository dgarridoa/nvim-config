return {
  -- activate with setl filetype=terminal
  "norcalli/nvim-terminal.lua",
  init = function()
    require("terminal").setup()
  end,
}
