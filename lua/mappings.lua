local merge_tb = vim.tbl_deep_extend

local function get_mappings_union()
  local Path = require "plenary.path"

  local config_dir = vim.fn.stdpath "config"
  local full_path = Path:new(config_dir, "lua", "mappings").filename
  local mapping_file_names = require("utils").scandir(full_path)

  local mappings = {}
  for _, file_name in ipairs(mapping_file_names) do
    table.insert(mappings, require("mappings." .. string.gsub(file_name, ".lua", "")))
  end

  return merge_tb("force", unpack(mappings))
end

return get_mappings_union()
