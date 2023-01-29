function! Run()
    exec "w"
    if &filetype == 'markdown'
        exec "MarkdownPreview"
    elseif &filetype == 'php'
        "exec "!php %"
        call ShowCmdResultInSplit('php '.expand("%"))
    elseif &filetype == 'go'
        exec "!go run %"
    elseif &filetype == 'python'
        exec "!python3 %"
    elseif &filetype == 'html'
        silent! exec "!open -a 'Google Chrome' %"
    elseif &filetype == 'sh'
        :!time bash %
    endif
endfunction

function! ShowCmdResultInSplit(cmd)
    let result = system(a:cmd)
    set splitbelow
    split [execute_result]
    normal! ggdG
    setlocal filetype=executeresult
    setlocal buftype=nofile
    nnoremap <buffer> q :bd<cr>
    resize 15
    call append(0, split(result, '\v\n'))
endfunction

command! -nargs=? -complete=buffer -bang R :call Run()


nnoremap <leader>r :call Run()<CR>

