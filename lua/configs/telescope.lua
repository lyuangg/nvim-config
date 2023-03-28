-- 不预览二进制文件
local previewers = require("telescope.previewers")
local Job = require("plenary.job")
local new_maker = function(filepath, bufnr, opts)
  filepath = vim.fn.expand(filepath)
  Job:new({
    command = "file",
    args = { "--mime-type", "-b", filepath },
    on_exit = function(j)
      local mime_type = vim.split(j:result()[1], "/")[1]
      if mime_type == "text" then
        previewers.buffer_previewer_maker(filepath, bufnr, opts)
      else
        -- maybe we want to write something to the buffer here
        vim.schedule(function()
          vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "BINARY" })
        end)
      end
    end
  }):sync()
end



require("telescope").setup{
  defaults = {
    buffer_previewer_maker = new_maker,
        prompt_prefix = '   ',
        scroll_strategy = 'limit',
        layout_strategy = 'vertical',
        sorting_strategy = 'ascending',
        preview = false,
        dynamic_preview_title = true,
        layout_config = {
            center = {
                preview_height = { 0.4, min = 5, max = 20 },
                height = { 0.8, min = 10, max = 40 },
                width = { 0.8, min = 80, max = 130 },
                preview_cutoff = 20,
                prompt_position = 'top', -- 'top' or 'bottom'
            },

            cursor = { --
                height = { 0.4, min = 6, max = 10 },
                width = { 0.4, min = 10, max = 30 },
                preview_cutoff = 0,
            },

            horizontal = {
                height = { 0.8, min = 10, max = 40 },
                width = { 0.94, min = 100, max = 130 },
                preview_width = 80,
                prompt_position = 'bottom',
                preview_cutoff = 0,
            },

            vertical = {
                preview_height = { 0.4, min = 5, max = 20 },
                height = { 0.8, min = 10, max = 40 },
                width = { 0.8, min = 80, max = 130 },
                preview_cutoff = 20,
                prompt_position = 'top', -- 'top' or 'bottom'
            },
        },
        mappings = {
            i = {
                ['<C-u>'] = false,
            }
        }
    },
    pickers = {
        find_files = {
            prompt_prefix = '  ' ,
            path_display = {}, -- Display full filepath
        },
        git_files = {
            path_display = {}, -- Display full filepat
        },
        commands = {
            prompt_prefix = '  ',
            layout_config = { width = { 0.9, min = 80, max = 130 } },
        },

        help_tags = { layout_strategy = 'horizontal', preview = true },

        live_grep = {
            prompt_prefix = '  ' ,
            layout_strategy = 'horizontal',
            preview = true
        },
    }
}

