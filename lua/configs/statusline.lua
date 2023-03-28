-- lualine config
require('lualine').setup {
    options = {
        icons_enabled = true,
        theme = 'auto', -- based on current vim colorscheme
        -- not a big fan of fancy triangle separators
        component_separators = {left = "", right = ""},
        section_separators = {left = "", right = ""},

        disabled_filetypes = {},
        always_divide_middle = true,
    },
    sections = {
        -- left
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { 'filename', {'b:gitsigns_blame_line', icon = ''} },
        -- right
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
    },
    inactive_sections = {
        lualine_a = { 'filename' },
        lualine_b = {},
        lualine_c = {},
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {
        lualine_a = {
            {
                'buffers',
                show_filename_only = true,
                hide_filename_extension = false,
                show_modified_status = true,
                mode = 2, -- 0: Shows buffer name
                -- 1: Shows buffer index
                -- 2: Shows buffer name + buffer index
                -- 3: Shows buffer number
                -- 4: Shows buffer name + buffer number
                -- max_length = vim.o.columns, -- Maximum width of buffers component,
                max_length = vim.o.columns * 2 / 3, -- Maximum width of buffers component,
                                        -- it can also be a function that returns
                                        -- the value of `max_length` dynamically.
                filetype_names = {
                    TelescopePrompt = 'Telescope',
                    dashboard = 'Dashboard',
                    packer = 'Packer',
                    fzf = 'FZF',
                    alpha = 'Alpha'
                }, -- Shows specific buffer name for that filetype ( { `filetype` = `buffer_name`, ... } )

                symbols = {
                    modified = ' ●',      -- Text to show when the buffer is modified
                    -- alternate_file = '#', -- Text to show to identify the alternate file
                    alternate_file = '', -- Text to show to identify the alternate file
                    directory =  '',     -- Text to show when the buffer is a directory
                },
            },
        },
    },
    extensions = {'aerial', 'nvim-tree', 'quickfix', 'nvim-dap-ui', 'man'}
}

vim.api.nvim_create_autocmd({"ChanOpen", "BufEnter"}, {
    callback = function()
        local bsize = vim.api.nvim_eval("len(getbufinfo({'buflisted':1}))")

        if bsize > 1 then
            vim.o.showtabline=2
            return
        end
        vim.cmd("set showtabline=1")
    end
})
