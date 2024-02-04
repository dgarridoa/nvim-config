return {
  "tpope/vim-fugitive",
  cmd = {
    "G",
    "Git",
    "Gsplit",
    "Gdiffsplit",
    "Ghdiffsplit",
    "Gedit",
    "Gread",
    "Gwrite",
    "Ggrep",
    "GMove",
    "GDelete",
    "GBrowse",
  },
  init = function()
    require("utils").load_mappings "fugitive"
  end,
}
