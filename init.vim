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
lua require("configs.bufferline")
lua require("configs.lspsaga")
lua require("configs.lspsign")
lua require("configs.filetree")
lua require("configs.comment")
lua require("configs.git")
lua require("configs.treesitter")
lua require("configs.clipboardimg")
lua require("configs.telescope")
lua require("configs.todo")
lua require("scripts.my")

" lua 插件快捷键
lua require('keymaps')

" macos
so ~/.config/nvim/macmap.vim

" 主题
set background=dark
colorscheme gruvbox
" colorscheme tokyonight
highlight Normal guibg=NONE ctermbg=None " 背景透明

