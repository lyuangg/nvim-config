" 基本配置, 快捷键
so ~/.config/nvim/basic.vim


" lua 插件
lua require('plugins')

" lua 插件配置
lua require("impatient")
lua require("configs.lsp")
lua require("configs.cmp")
lua require("configs.outline")
lua require("configs.statusline")
lua require("configs.filetree")
lua require("configs.comment")
lua require("configs.git")
lua require("configs.treesitter")
lua require("configs.clipboardimg")
lua require("configs.telescope")
lua require("scripts.my")

" lua 插件快捷键
lua require('keymaps')

" 主题
set background=dark
colorscheme gruvbox
highlight Normal guibg=NONE ctermbg=None " 背景透明

autocmd BufWritePre *.go :lua vim.lsp.buf.formatting()

