local M = {}
function M.config()
	-- nvim-treesitter config
	require 'nvim-treesitter.configs'.setup {
		-- ensure_installed = "maintained", -- for installing all maintained parsers
		ensure_installed = { "c", "javascript", "go", "lua", "php", "html", "css", "python", "typescript", "vue", "yaml", "json", "bash", "markdown"}, -- for installing specific parsers
		sync_install = true, -- install synchronously
        auto_install = true,
		ignore_install = {}, -- parsers to not install
		highlight = {
			enable = true,
            disable = {},
			additional_vim_regex_highlighting = false, -- disable standard vim highlighting
		},
        matchup = {
          enable = true,              -- mandatory, false will disable the whole extension
        },
        indent = {
          enable = true,
          disable = {},
        },
        autotag = {
          enable = true,
        },
	}
end

return M
