local options = {
  settings = {
    options = {
      on_venv_activate_callback = nil, -- callback function for after a venv activates
      enable_default_searches = true, -- switches all default searches on/off
      enable_cached_venvs = true, -- use cached venvs that are activated automatically when a python file is registered with the LSP.
      cached_venv_automatic_activation = true, -- if set to false, the VenvSelectCached command becomes available to manually activate them.
      activate_venv_in_terminal = true, -- activate the selected python interpreter in terminal windows opened from neovim
      set_environment_variables = true, -- sets VIRTUAL_ENV or CONDA_PREFIX environment variables
      notify_user_on_venv_activation = true, -- notifies user on activation of the virtual env
      search_timeout = 5, -- if a search takes longer than this many seconds, stop it and alert the user
      debug = true, -- enables you to run the VenvSelectLog command to view debug logs
      -- fd_binary_name = M.find_fd_command_name(), -- plugin looks for `fd` or `fdfind` but you can set something else here

      -- telescope viewer options
      on_telescope_result_callback = nil, -- callback function for modifying telescope results
      show_telescope_search_type = true, -- shows which of the searches found which venv in telescope
      telescope_filter_type = "substring", -- when you type something in telescope, filter by "substring" or "character"
    },
  },
}
return options
