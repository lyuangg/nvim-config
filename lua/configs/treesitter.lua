-- nvim-treesitter config
require 'nvim-treesitter.configs'.setup {
    ensure_installed = {"lua", "vim", "help", "c", "javascript", "go", "php", "html", "css", "python", "typescript", "vue", "yaml", "json", "bash", "markdown", "markdown_inline"}, -- for installing specific parsers
    sync_install = true, -- install synchronously
    auto_install = false,
    ignore_install = {}, -- parsers to not install
    highlight = {
        enable = true,
        disable = {},
        additional_vim_regex_highlighting = false, -- disable standard vim highlighting
    },
    -- matchup = {
    --     enable = true,              -- mandatory, false will disable the whole extension
    -- },
    indent = {
        enable = true,
        disable = {},
    },
    autotag = {
        enable = true,
    }
}

