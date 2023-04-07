function! Run()
    exec "w"
    let path = getcwd() . '/run.sh'
    if filereadable(path)
        " exec "rightb vsplit term://" . path
        exec "bo 20split term://" . path
        return
    endif

    if &filetype == 'markdown'
        " let l:fpath = "!open -a 'Google Chrome' ". fnameescape(expand("%"))
        " exec l:fpath
        exec "MarkdownPreview"
    elseif &filetype == 'javascript'
        " exec "bo 20split term://node ". fnameescape(expand("%"))
        :!node %
    elseif &filetype == 'php'
        call ShowCmdResultInSplit('php '.expand("%"))
        " exec "bo 20split term://php ". fnameescape(expand("%"))
    elseif &filetype == 'go'
        :!go run %
        " exec "bo 20split term://go run %"
    elseif &filetype == 'python'
        exec "bo 20split term://python3 %"
    elseif &filetype == 'html'
        silent! exec "!open -a 'Google Chrome' %"
    elseif &filetype == 'sh'
        " :!time bash %
        exec "bo 20split term://time bash %"
    endif
endfunction

function! ShowCmdResultInSplit(cmd)
    set splitbelow
    split [execute_result]
    normal! ggdG
    setlocal filetype=executeresult
    setlocal buftype=nofile
    nnoremap <silent> <buffer> q :bd<cr>
    resize 15
    highlight MyGroup guifg=orange
    highlight MyGroup2 guifg=grey
    match MyGroup /\[CMD\]/
    2match MyGroup2 /Type\ q\ to\ quit!/
    call append(0, ['[CMD] '. a:cmd])
    call append(1, split(system(a:cmd), '\v\n'))
    put = 'Type q to quit!'
endfunction

command! -nargs=? -complete=buffer -bang R :call Run()


nnoremap <leader>r :call Run()<CR>

