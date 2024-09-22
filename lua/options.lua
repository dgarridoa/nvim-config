local o = vim.o
local opt = vim.opt
local g = vim.g

-------------------------------------- options ------------------------------------------
o.laststatus = 3 -- global statusline
o.showmode = false

o.clipboard = "unnamedplus"
o.cursorline = false

-- enable persistent undo
g.undofile = true

-- indenting
o.expandtab = true
o.shiftwidth = 2
o.smartindent = true
o.tabstop = 2
o.softtabstop = 2

opt.fillchars = { eob = " " }
o.ignorecase = true
o.smartcase = true
o.mouse = "a"

-- numbers
o.relativenumber = true
o.number = true
o.numberwidth = 2
o.ruler = false

-- disable nvim intro
opt.shortmess:append "sI"

o.signcolumn = "yes"
o.splitbelow = true
o.splitright = true
o.termguicolors = true
o.timeoutlen = 400

-- interval for writing swap file to disk, also used by gitsigns
o.updatetime = 250

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append "<>[]hl"

-- leader key
g.mapleader = " "

-- disable some default providers
for _, provider in ipairs { "node", "perl", "python3", "ruby" } do
  vim.g["loaded_" .. provider .. "_provider"] = 0
end
