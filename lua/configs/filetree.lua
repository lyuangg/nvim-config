-- nvim-tree config

local api = require('nvim-tree.api')

require("nvim-tree").setup({
    disable_netrw = true,
    update_focused_file  = {
        enable      = true,
        update_cwd  = true,
        ignore_list = {}
    },
    view = {
        width = 30,
        mappings = {
            list = {
                { key = "u", action = "dir_up" },
                {
                    key = "<CR>",
                    action = "edit_no_close",
                    action_cb = function(node)
                        api.node.open.edit(node, { close_tree = true, })
                        api.tree.close()
                    end,
                },
            },
        },
    },
    renderer = {
        group_empty = true,
        highlight_opened_files = "icon",
    },
    filters = {
        dotfiles = true,
    },
    actions = {
        change_dir = {
            global = false,
        },
        open_file = {
            -- quit_on_open = true
        }
    }
})

local function open_nvim_tree(data)
    -- buffer is a directory
    local directory = vim.fn.isdirectory(data.file) == 1

    if not directory then
        return
    end

    -- change to the directory
    vim.cmd.cd(data.file)

    -- open the tree
    require("nvim-tree.api").tree.open()
end

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })



-- local nvim_tree_events = require('nvim-tree.events')
-- local bufferline_api = require('bufferline.api')

-- local function get_tree_size()
--   return require'nvim-tree.view'.View.width
-- end

-- nvim_tree_events.subscribe('TreeOpen', function()
--   bufferline_api.set_offset(get_tree_size())
-- end)

-- nvim_tree_events.subscribe('Resize', function()
--   bufferline_api.set_offset(get_tree_size())
-- end)

-- nvim_tree_events.subscribe('TreeClose', function()
--   bufferline_api.set_offset(0)
-- end)
