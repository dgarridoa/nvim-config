return {
  "stevearc/oil.nvim",
  opts = {},
  init = function()
    require("oil").setup {
      keymaps = {
        ["g?"] = "actions.show_help",
        ["<CR>"] = "actions.select",
        ["<C-v>"] = "actions.select_vsplit",
        ["<C-h>"] = "actions.select_split",
        ["<C-t>"] = "actions.select_tab",
        ["<C-p>"] = "actions.preview",
        ["<C-x>"] = "actions.close",
        ["<C-r>"] = "actions.refresh",
        ["."] = "actions.parent",
        ["_"] = "actions.open_cwd",
        ["`"] = "actions.cd",
        ["~"] = "actions.tcd",
        ["gs"] = "actions.change_sort",
        ["gx"] = "actions.open_external",
        ["h"] = "actions.toggle_hidden",
        ["g\\"] = "actions.toggle_trash",
      },
    }
  end,
  dependencies = { "nvim-tree/nvim-web-devicons" },
}
