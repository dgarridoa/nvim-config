local merge_tb = vim.tbl_deep_extend

return merge_tb(
  "force",
  require "mappings.bufferline",
  require "mappings.comment",
  require "mappings.dap",
  require "mappings.general",
  require "mappings.gitsigns",
  require "mappings.harpoon",
  require "mappings.lspconfig",
  require "mappings.nvimtree",
  require "mappings.oil",
  require "mappings.telescope",
  require "mappings.whichkey"
)
