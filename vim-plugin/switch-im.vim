let g:have_input_switch = 0
let g:last_input = ''

function! SwitchIm()
    let g:last_input = trim(system("/usr/local/bin/im-select"))
    if g:have_input_switch == 0 
        let haveSwitch = system('which im-select')
        if matchstr(haveSwitch, 'not found') == ''
            let g:have_input_switch = 2
        else
            let g:have_input_switch = 1
        endif
    endif
    if g:have_input_switch == 2
        echom system('im-select com.apple.keylayout.ABC')
    endif
    
    "let currentIm = system("/usr/local/bin/im-select")
    "if trim(currentIm) == 'com.apple.keylayout.ABC'
        "echom system('/usr/local/bin/im-select com.sogou.inputmethod.sogou.pinyin')
    "else
        "echom system('/usr/local/bin/im-select com.apple.keylayout.ABC')
    "endif

endfunction

function! SwitchIm2()
    echom 'switchim2'
    echom g:last_input
    if g:have_input_switch == 0 
        let haveSwitch = system('which im-select')
        if matchstr(haveSwitch, 'not found') == ''
            let g:have_input_switch = 2
        else
            let g:have_input_switch = 1
        endif
    endif
    if g:have_input_switch == 2 && g:last_input != ''
         echom system('im-select '. g:last_input)
    endif
    
    "let currentIm = system("/usr/local/bin/im-select")
    "if trim(currentIm) == 'com.apple.keylayout.ABC'
        "echom system('/usr/local/bin/im-select com.sogou.inputmethod.sogou.pinyin')
    "else
        "echom system('/usr/local/bin/im-select com.apple.keylayout.ABC')
    "endif

endfunction
"command! -nargs=? -complete=buffer -bang SwitchIm :call SwitchIm()<CR>

autocmd InsertLeave * call SwitchIm()

" autocmd InsertEnter *.md,*.txt call SwitchIm2()
autocmd InsertEnter * call SwitchIm2()

