require('lspsaga').setup{
    ui = {
        -- This option only works in Neovim 0.9
        title = true,
        -- Border type can be single, double, rounded, solid, shadow.
        border = "rounded",
        winblend = 0,
        expand = "",
        collapse = "",
        code_action = "💡",
        incoming = " ",
        outgoing = " ",
        hover = ' ',
        kind = {},
    },
    scroll_preview = {
        scroll_down = "<C-f>",
        scroll_up = "<C-u>",
    },
    symbol_in_winbar = {
        enable = true,
        separator = ' > ',
        ignore_patterns={},
        hide_keyword = true,
        show_file = true,
        folder_level = 2,
        respect_root = false,
        color_mode = false,
    },
}
