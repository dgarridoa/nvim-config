return {
  "mbbill/undotree",
  cmd = "UndotreeToggle",
  init = function()
    require("utils").load_mappings "undotree"
  end,
  config = function()
    require("configs.undotree").setup()
  end,
}
