
-- f: file tree
vim.keymap.set('n', '<leader>e', ':NvimTreeFocus<cr>')


-- buffers
vim.keymap.set('n', '<leader>1', function() require("bufferline").go_to_buffer(1, true) end, { noremap=true, silent=true })
vim.keymap.set('n', '<leader>2', function() require("bufferline").go_to_buffer(2, true) end, { noremap=true, silent=true })
vim.keymap.set('n', '<leader>3', function() require("bufferline").go_to_buffer(3, true) end, { noremap=true, silent=true })
vim.keymap.set('n', '<leader>4', function() require("bufferline").go_to_buffer(4, true) end, { noremap=true, silent=true })
vim.keymap.set('n', '<leader>5', function() require("bufferline").go_to_buffer(5, true) end, { noremap=true, silent=true })
vim.keymap.set('n', '<leader>6', function() require("bufferline").go_to_buffer(6, true) end, { noremap=true, silent=true })
vim.keymap.set('n', '<leader>7', function() require("bufferline").go_to_buffer(7, true) end, { noremap=true, silent=true })
vim.keymap.set('n', '<leader>8', function() require("bufferline").go_to_buffer(8, true) end, { noremap=true, silent=true })
vim.keymap.set('n', '<leader>9', function() require("bufferline").go_to_buffer(9, true) end, { noremap=true, silent=true })

vim.keymap.set('n', '<leader>bn', ':BufferLineCycleNext<cr>', { noremap=true, silent=true })
vim.keymap.set('n', '<leader>bp', ':BufferLineCyclePrev<cr>', { noremap=true, silent=true })

-- outline
vim.keymap.set('n', '<leader>o', ':AerialOpen<cr>')

-- telescope
vim.keymap.set('n', '<leader>ff', function() require'telescope.builtin'.find_files{} end)
vim.keymap.set('n', '<leader>fb', function() require'telescope.builtin'.buffers{} end)
vim.keymap.set('n', '<leader>fg', function() require'telescope.builtin'.live_grep{} end)
-- vim.keymap.set({'n', 'i'}, '<C-p>', function() require'telescope.builtin'.registers{} end)

-- startify
vim.keymap.set('n', '<leader>n', ':Startify<cr>')

-- lsp 快捷键
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { noremap=true, silent=true })
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { noremap=true, silent=true })
vim.keymap.set('n', 'gr', vim.lsp.buf.references, { noremap=true, silent=true })
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { noremap=true, silent=true })
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.formatting, { noremap=true, silent=true })
vim.keymap.set('n', '<leader>lh', vim.lsp.buf.signature_help, { noremap=true, silent=true })
vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, { noremap=true, silent=true })
vim.keymap.set('n', '<leader>ln', vim.diagnostic.goto_next, { noremap=true, silent=true })
vim.keymap.set('n', '<leader>lp', vim.diagnostic.goto_prev, { noremap=true, silent=true })
local isshowdiagonstic = true
vim.keymap.set('n', '<leader>ld', function()
    if isshowdiagonstic == true
    then
        vim.diagnostic.hide()
        isshowdiagonstic = false
    else
        vim.diagnostic.show()
        isshowdiagonstic = true
    end
end, { noremap=true, silent=true })

-- vim.keymap.set('n', '<leader>ll', ':LspStop<cr>', { noremap=true, silent=true })
local isenablelsp = true
vim.keymap.set('n', '<leader>ll', function() 
    if isenablelsp == true
    then
        vim.cmd('LspStop')
        isenablelsp = false
    else
        vim.cmd('LspStart')
        isenablelsp = true
    end
end, { noremap=true, silent=true })

-- 折叠
-- 开启 Folding
vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
vim.wo.foldlevel = 99

-- substitute
vim.keymap.set("n", "s", "<cmd>lua require('substitute').operator()<cr>", { noremap = true, silent=true  })
vim.keymap.set("n", "ss", "<cmd>lua require('substitute').line()<cr>", { noremap = true, silent=true  })
vim.keymap.set("n", "S", "<cmd>lua require('substitute').eol()<cr>", { noremap = true, silent=true  })
vim.keymap.set("x", "s", "<cmd>lua require('substitute').visual()<cr>", { noremap = true, silent=true  })


