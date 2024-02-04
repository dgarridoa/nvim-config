require "init"

require("utils").load_mappings()

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  require("bootstrap").lazy(lazypath)
end

vim.opt.rtp:prepend(lazypath)
require("lazy").setup("plugins", require "configs.lazy_nvim")
