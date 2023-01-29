local M = {}

function M.showtabline()
    -- 设置 tabline
    vim.api.nvim_create_autocmd({"ChanOpen", "BufEnter"}, {
        callback = function(ev)
            -- vim.pretty_print(ev)
            local bsize = vim.api.nvim_eval("len(getbufinfo({'buflisted':1}))") 

            if bsize > 1 then
                vim.o.showtabline=2
                return
            end
            vim.cmd("set showtabline=1")
            return
        end
    })
end

return M
