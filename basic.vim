" 基础
set nocompatible "关闭兼容模式
set backspace=indent,eol,start  " 关闭兼容模式下退格键使用
set encoding=utf-8  " 编码
syntax on    " 语法高亮, 关键字上色
filetype plugin indent on "开启文件类型检查, 三个命令: filetype on, filetype plugin on, filetype indent on 
set showmode " 在底部显示，当前处于命令模式还是插入模式。
set showcmd " 命令模式下，在底部显示，当前键入的指令。
" set wildmenu
set mouse=a " 鼠标
set updatetime=100 
set hidden " 取消未保存打开新buffer 的限制
set clipboard=unnamedplus,unnamed " 剪切板
set t_Co=256 " 开启256 支持

" 真彩色支持
if has("termguicolors")
    " enable true color
    if $TERM_PROGRAM !=? "Apple_Terminal"
        set termguicolors
    endif
endif


" 缩进
set shiftround  " 复制缩进空格问题
set autoindent "自动缩进
set smartindent
set tabstop=4 " 按下 Tab 键时，Vim 显示的空格数
set shiftwidth=4 " 在文本上按下>>（增加一级缩进）、<<（取消一级缩进）或者==（取消全部缩进）时，每一级的字符数。
set expandtab "tab 转换为空格
set softtabstop=4 " Tab 转为多少个空格。


" 外观
set nu "显示行号
set cursorline  " 高亮当前行
set wrap " 自动换行, nowap 不自动换行
set linebreak " 不在单词内换行
set wrapmargin=2 " 指定折行处与编辑窗口的右边缘之间空出的字符数。
set scrolloff=7                 " 保持在光标上下最少行数
set sidescrolloff=15            " 水平滚动
set laststatus=2 " 是否显示状态栏。0 表示不显示，1 表示只在多窗口时显示，2 表示显示。
set ruler " 在状态栏显示光标的当前位置（位于哪一行哪一列）。

set guifont=SauceCodePro\ Nerd\ Font\ Mono:h12


" 搜索高亮
set hlsearch "搜索高亮
set incsearch " 搜索模式时，每输入一个字符，就自动跳到第一个匹配的结果
set ignorecase " 搜索时忽略大小写。
set smartcase " 只有一个大写字母的搜索词，将大小写敏感
set grepprg=grep\ -rn\ $*\ \ --exclude-dir=.git " grep 设置
set path+=**
set suffixesadd+=.php,.js,.vue,.css,.go

" 编辑
set nowritebackup
set nobackup "不备份
" set noswapfile " 不创建交换文件。交换文件主要用于系统崩溃时恢复文件，文件名的开头是.、结尾是.swp。
set undofile " 保留撤销历史。
" 设置备份文件、交换文件、操作历史文件的保存位置, 结尾的//表示生成的文件名带有绝对路径，路径中用%替换目录分隔符，这样可以防止文件重名。
set backupdir=~/.vim/.backup//  
set directory=~/.vim/.swp//
set undodir=~/.vim/.undo//
set noerrorbells " 出错时，不要发出响声
set visualbell " 出错时，发出视觉提示，通常是屏幕闪烁。
set history=1000 " 记住多少次历史操作
set autoread "打开文件监视。如果在编辑过程中文件发生外部改变（比如被别的编辑器编辑了），就会发出提示。

"取消自动添加注释行
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" 禁用内置插件
let g:loaded_matchparen        = 1 " 高亮匹配括号
let g:loaded_matchit           = 1 " %来实现括号之间的跳转
let g:loaded_logiPat           = 1 " pi_logipat 逻辑模式
let g:loaded_rrhelper          = 1
let g:loaded_shada_plugin      = 1
let g:loaded_netrw             = 1
let g:loaded_netrwPlugin       = 1
let g:loaded_tutor_mode_plugin = 1

" 快捷键
let mapleader = " "

" 结尾分号
noremap <silent> <Leader>, $a,<ESC>
noremap <silent> <Leader>; $a;<ESC>

"取消高亮
nnoremap <silent> <Leader>h :noh<return> 

"search
xnoremap * :<C-u>call <SID>VSetSearch('/')<CR>/<C-R>=@/<CR><CR> 
xnoremap # :<C-u>call <SID>VSetSearch('?')<CR>?<C-R>=@/<CR><CR>

function! s:VSetSearch(cmdtype)
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g') 
  let @s = temp
endfunction

" 移动
inoremap <C-f> <Right>
nnoremap j gj
nnoremap k gk
nnoremap 0 g0
nnoremap $ g$
nnoremap ^ g^
nnoremap H ^
nnoremap L $

" 命令行
cnoremap <C-a> <Home>

" terminal
tnoremap <Esc> <C-\><C-n>

" quit
nnoremap <Leader>q :q<CR>
nnoremap <Leader>Q :qall!<CR>
nnoremap <Leader>w :w<CR>

" esc
inoremap jj <esc>

" buffers
noremap <silent> <Leader>x :bp<cr>:bd #<cr> " 删除buffer
noremap <silent> <Leader>X :bd!<CR> " 删除buffer
noremap <silent> <Leader>bb <C-6>
noremap <silent> <Leader>bo :%bd<cr>:e#<cr>:bd#<cr> " only buffer
noremap <silent> <Leader>bn :ene<CR>
noremap <silent> <Tab> :bn<CR>
noremap <silent> <S-Tab> :bp<CR>


" startify
let g:ascii = [
    \ '  __   ___   _   _    _   _ ',
    \ '  \ \ / / | | | / \  | \ | |',
    \ '   \ V /| | | |/ _ \ |  \| |',
    \ '    | | | |_| / ___ \| |\  |',
    \ '    |_|  \___/_/   \_\_| \_|',
    \ ''
    \]
let g:startify_custom_header = g:ascii
let g:startify_lists = [
\ { 'type': 'files',     'header': ['   MRU']            },
\ { 'type': 'sessions',  'header': ['   Sessions']       },
\ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
\ { 'type': 'commands',  'header': ['   Commands']       },
\ ]
let g:startify_files_number = 5
let g:startify_session_autoload    = 1
let g:startify_session_persistence = 1
" let g:startify_session_dir = '~/.vim/session'
let g:startify_session_before_save = [ 'silent! tabdo NvimTreeClose', 'silent! LspStop']
let g:startify_commands = [
    \ {'r': ['Refresh Startify', 'Startify']},
    \ {'S': ['Session Save', 'SSave '.fnamemodify(getcwd(), ':~:t')]},
    \ {'d': ['Session Delete', 'SDelete']},
    \ {'c': ['Session Close', 'SClose']},
    \ ]
autocmd User Startified setlocal cursorline


" preview markdown
let g:mkdp_browser = 'min'
let g:mkdp_theme = 'light'
