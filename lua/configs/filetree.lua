-- nvim-tree config

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
            quit_on_open = true
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
