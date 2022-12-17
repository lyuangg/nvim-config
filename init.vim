" 基本配置, 快捷键
so ~/.config/nvim/basic.vim

" lua 插件
lua require('plugins')

" lua 插件配置
lua require("impatient")
lua require("configs.lsp")
lua require("configs.outline").config()
lua require("configs.statusline").config()
lua require("configs.bufferline").config()
lua require("configs.filetree").config()
lua require("configs.comment").config()
lua require("configs.git").config()
lua require("configs.treesitter").config()

" lua 插件快捷键
lua require('keymaps')

" 主题
set background=dark
colorscheme gruvbox

" neovide 
set guifont=SauceCodePro\ Nerd\ Font\ Mono:h12
if exists("g:neovide")
    let g:neovide_input_use_logo=v:true
    let g:neovide_refresh_rate_idle=5

    let g:neovide_refresh_rate=60
    let g:neovide_no_idle=v:false
    let g:neovide_fullscreen=v:false
    let g:neovide_cursor_trail_length=0.5
    let g:neovide_cursor_antialiasing=v:true

    let g:neovide_transparency=0.0
    let g:transparency = 0.90
    let g:neovide_background_color = '#0f1117'.printf('%x', float2nr(255 * g:transparency))

    let g:neovide_floating_blur_amount_x = 2.0
    let g:neovide_floating_blur_amount_y = 2.0

    let g:neovide_cursor_animation_length=0.05

    let g:neovide_animate_in_insert_mode=0

    let g:neovide_cursor_vfx_mode = "pixiedust"
    let g:neovide_cursor_vfx_opacity=200.0
    let g:neovide_cursor_vfx_particle_lifetime=1.2
    let g:neovide_cursor_vfx_particle_density=7.0
    let g:neovide_cursor_vfx_particle_speed=10.0
    let g:neovide_cursor_vfx_particle_phase=1.5
    let g:neovide_cursor_vfx_particle_curl=1.0

    set mouse=a

    autocmd InsertLeave * let g:neovide_cursor_animation_length=0.05
    autocmd InsertEnter * let g:neovide_cursor_animation_length=0
endif


autocmd BufWritePre *.go :lua vim.lsp.buf.formatting()


