
-- f: file tree
vim.keymap.set('n', '<leader>E', ':NvimTreeFocus<cr>', { noremap=true, silent=true })
vim.keymap.set('n', '<leader>e', ':NvimTreeOpen<cr>', { noremap=true, silent=true })
-- vim.keymap.set('n', '<leader>e', '::NvimTreeFindFileToggle<cr>', { noremap=true, silent=true })


-- vim.keymap.set('n', '<leader>1', '<cmd>lua require("bufferline").go_to_buffer(1, true)<cr>', { noremap=true, silent=true })
vim.keymap.set('n', '<leader>1', ':LualineBuffersJump! 1<cr>', { noremap=true, silent=true })
vim.keymap.set('n', '<leader>2', ':LualineBuffersJump! 2<cr>', { noremap=true, silent=true })
vim.keymap.set('n', '<leader>3', ':LualineBuffersJump! 3<cr>', { noremap=true, silent=true })
vim.keymap.set('n', '<leader>4', ':LualineBuffersJump! 4<cr>', { noremap=true, silent=true })
vim.keymap.set('n', '<leader>5', ':LualineBuffersJump! 5<cr>', { noremap=true, silent=true })
vim.keymap.set('n', '<leader>6', ':LualineBuffersJump! 6<cr>', { noremap=true, silent=true })
vim.keymap.set('n', '<leader>7', ':LualineBuffersJump! 7<cr>', { noremap=true, silent=true })
vim.keymap.set('n', '<leader>8', ':LualineBuffersJump! 8<cr>', { noremap=true, silent=true })
vim.keymap.set('n', '<leader>9', ':LualineBuffersJump! 9<cr>', { noremap=true, silent=true })

-- outline
vim.keymap.set('n', '<leader>o', ':AerialOpen<cr>', { noremap=true, silent=true })
vim.keymap.set('n', '<leader>oo', ':AerialOpen<cr>', { noremap=true, silent=true })

-- telescope
vim.keymap.set('n', '<leader>ff', function() require'telescope.builtin'.find_files{} end, { noremap=true, silent=true })
vim.keymap.set('n', '<leader>bf', function() require'telescope.builtin'.buffers{} end, { noremap=true, silent=true })
vim.keymap.set('n', '<leader>fg', function() require'telescope.builtin'.live_grep{} end, { noremap=true, silent=true })
vim.keymap.set('n', '<leader>c', function() require'telescope.builtin'.commands{} end, { noremap=true, silent=true })
vim.keymap.set('n', '<leader>fh', function() require'telescope.builtin'.help_tags{} end, { noremap=true, silent=true })
vim.keymap.set('n', '<leader>fk', function() require'telescope.builtin'.keymaps{} end, { noremap=true, silent=true })
vim.keymap.set('n', '<leader>fb', function() require'telescope.builtin'.builtin{} end, { noremap=true, silent=true })
vim.keymap.set('n', '<leader>fd', function() require'telescope.builtin'.diagnostics{} end, { noremap=true, silent=true })

-- startify
vim.keymap.set('n', '<leader>n', ':Startify<cr>', { noremap=true, silent=true })

-- lsp 快捷键
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { noremap=true, silent=true })
vim.keymap.set('n', 'gD', '<cmd>Lspsaga peek_peek_definition<CR>', { noremap=true, silent=true })
vim.keymap.set('n', 'gh', '<cmd>Lspsaga lsp_finder<CR>', { noremap=true, silent=true })
vim.keymap.set('n', 'gr', '<cmd>Lspsaga rename<CR>', { noremap=true, silent=true })
vim.keymap.set('n', 'K', '<cmd>Lspsaga hover_doc<CR>', { noremap=true, silent=true })
vim.keymap.set('n', '<leader>F', vim.lsp.buf.format, { noremap=true, silent=true })
vim.keymap.set('n', '<leader>ln', vim.diagnostic.goto_next, { noremap=true, silent=true })
vim.keymap.set('n', '<leader>lp', vim.diagnostic.goto_prev, { noremap=true, silent=true })
vim.keymap.set('n', '<leader>la', '<cmd>Lspsaga code_action<CR>', { noremap=true, silent=true })
vim.keymap.set('n', '<leader>lo', '<cmd>Lspsaga outline<CR>', { noremap=true, silent=true })

-- 代码折叠
vim.opt.foldmethod     = 'expr'
vim.opt.foldexpr       = 'nvim_treesitter#foldexpr()'
vim.cmd("set nofoldenable")

-- substitute
vim.keymap.set("n", "s", "<cmd>lua require('substitute').operator()<cr>", { noremap = true, silent=true  })
vim.keymap.set("n", "ss", "<cmd>lua require('substitute').line()<cr>", { noremap = true, silent=true  })
vim.keymap.set("n", "S", "<cmd>lua require('substitute').eol()<cr>", { noremap = true, silent=true  })
vim.keymap.set("x", "s", "<cmd>lua require('substitute').visual()<cr>", { noremap = true, silent=true  })

-- comment
vim.keymap.set("n", '<leader>/', ":CommentToggle<cr>", { noremap = true, silent=true  })


-- paste image
vim.keymap.set("n", '<leader>p', ":PasteImg<cr>", {noremap= true, silent=true })

-- test
vim.keymap.set("n", '<leader>tl', ":TestLast<cr>", {noremap= true, silent=true })
vim.keymap.set("n", '<leader>tt', ":TestLast<cr>", {noremap= true, silent=true })
vim.keymap.set("n", '<leader>tn', ":TestNearest<cr>", {noremap= true, silent=true })
vim.keymap.set("n", '<leader>tf', ":TestFile<cr>", {noremap= true, silent=true })
vim.keymap.set("n", '<leader>ts', ":TestSuite<cr>", {noremap= true, silent=true })

-- git
vim.keymap.set("n", '<leader>gd', ":DiffviewOpen<cr>", {noremap= true, silent=true })
vim.keymap.set("n", '<leader>gh', ":DiffviewFileHistory %<cr>", {noremap= true, silent=true })
vim.keymap.set("n", '<leader>gq', ":DiffviewClose<cr>", {noremap= true, silent=true })
vim.keymap.set("n", '<leader>gH', ":DiffviewFileHistory<cr>", {noremap= true, silent=true })
vim.keymap.set("n", '<leader>gn', ":Gitsigns next_hunk<cr>", {noremap= true, silent=true })
vim.keymap.set("n", '<leader>gp', ":Gitsigns prev_hunk<cr>", {noremap= true, silent=true })

-- 使用gx命令打开链接
vim.keymap.set("n", "gx", ":lua Open_url('n')<cr>", {noremap= true, silent=true })
vim.keymap.set("x", "gx", ":lua Open_url('v')<cr>", {noremap= true, silent=true })

-- openfile
-- vim.keymap.set("n", "gf", ":lua Open_file('n')<cr>", {noremap= true, silent=true })
vim.keymap.set("x", "gf", ":lua Open_file('v')<cr>", {noremap= true, silent=true })


-- obsidian
vim.keymap.set(
  "n",
  "gf",
  function()
    if require('obsidian').util.cursor_on_markdown_link() then
      return "<cmd>ObsidianFollowLink<CR>"
    else
      return "<cmd>lua Open_file('n')<CR>"
    end
  end,
  { noremap = false, expr = true}
)
vim.keymap.set("n", "<leader>of", ":ObsidianQuickSwitch<cr>", {noremap= true, silent=true })
vim.keymap.set("n", "<leader>ob", ":ObsidianOpen<cr>", {noremap= true, silent=true })
