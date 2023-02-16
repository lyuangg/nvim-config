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
        lualine_c = { 'filename' },
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
                max_length = vim.o.columns, -- Maximum width of buffers component,
                                        -- it can also be a function that returns
                                        -- the value of `max_length` dynamically.
                symbols = {
                    modified = ' ●',      -- Text to show when the buffer is modified
                    -- alternate_file = '#', -- Text to show to identify the alternate file
                    alternate_file = '', -- Text to show to identify the alternate file
                    directory =  '',     -- Text to show when the buffer is a directory
                },

                -- cond = function()
                --     if vim.api.nvim_eval("len(getbufinfo({'buflisted':1}))") > 1 then
                --         vim.o.showtabline=2
                --         return true
                --     end
                --     vim.cmd("set showtabline=1")
                --     return false
                -- end
            },
        },
    },
    extensions = {'aerial', 'nvim-tree', 'quickfix'}
}

