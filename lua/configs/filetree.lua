local M = {}
function M.config()
	-- nvim-tree config
	require 'nvim-tree'.setup {
		disable_netrw        = true,
		hijack_netrw         = true,
		open_on_setup        = false,
		ignore_ft_on_setup   = {},
		auto_reload_on_write = true,
		open_on_tab          = false,
		hijack_cursor        = false,
		update_cwd           = false,
		update_focused_file  = {
			enable      = true,
			update_cwd  = true,
			ignore_list = {}
		},
		system_open          = {
			cmd  = nil,
			args = {}
		},
		filters              = {
			dotfiles = false,
			custom = {}
		},
		git                  = {
			enable = true,
			ignore = false,
			timeout = 500,
		},
		view                 = {
            adaptive_size = true,
			hide_root_folder = false,
			side = 'left',
			mappings = {
				custom_only = false,
				list = {
                    { key = "u", action = "dir_up" },
                }
			},
		},
		trash                = {
			cmd = "trash",
			require_confirm = true
		},
		actions              = {
			change_dir = {
				global = true,
			},
			open_file = {
				quit_on_open = true,
			}
		}
	}
end

return M
