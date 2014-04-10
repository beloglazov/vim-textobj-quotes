" textobj-quotes: a text object for quotes of any kind
" Author: Anton Beloglazov
" Version: 0.1.0


if exists('g:loaded_textobj_quotes')
    finish
endif


call textobj#user#plugin('quote', {
    \ '-': {
    \     '*sfile*': expand('<sfile>:p'),
    \     'select-a': 'aq',  '*select-a-function*': 's:select_a',
    \     'select-i': 'iq',  '*select-i-function*': 's:select_i',
    \ }})

function! s:quote_regex(quote)
    if &filetype ==# 'vim'
        return '\v(\\|^\s*' . a:quote . '*)@<!' . a:quote
    else
        return '\v(\\)@<!' . a:quote
    endif
endfunction

function! s:get_quotes(str)
    let unescaped = substitute(a:str, '\v\\+(''|"|`)', '', 'g')
    return substitute(unescaped, '\v[^''"`]', '', 'g')
endfunction

function! s:get_buffer_head()
    let s:line = line('.')
    let s:col = col('.') - 2
    if s:col < 0
        let s:line -= 1
        if s:line < 1
            let s:line = 1
            let s:col = 0
        else
            let s:col = strlen(getline(s:line))
        endif
    endif
    let lines = getline(0, s:line)
    let lines[-1] = lines[-1][: s:col]
    if &filetype ==# 'vim'
        let n = len(lines)
        let i = 0
        while i < n
            let lines[i] = substitute(lines[i], '\v^\s*"+', '', 'g')
            let i += 1
        endwhile
    endif
    return join(lines, '')
endfunction

function! s:get_buffer_tail()
    let s:col = col('.')
    let lines = getline('.', '$')
    let lines[0] = lines[0][s:col - 1 :]
    return join(lines, '')
endfunction

function! s:parse_quotes(str)
    let opened = []
    let len = strlen(a:str)
    let i = 0
    while i < len
        let c = a:str[i]
        let pos = index(opened, c)
        if pos == -1
            call add(opened, c)
        elseif pos == 0
            let opened = []
        else
            let opened = opened[:(pos - 1)]
        endif
        let i += 1
    endwhile
    return opened
endfunction

function! s:get_first_closing_quote(str, opened)
    let len = strlen(a:str)
    let i = 0
    while i < len
        let c = a:str[i]
        let pos = index(a:opened, c)
        if pos != -1
            return c
        endif
        let i += 1
    endwhile
    return ''
endfunction

function! s:format_output(object_type, start_pos, end_pos)
    let start_pos = a:start_pos
    let end_pos = a:end_pos
    if a:object_type ==? 'i'
        let start_pos[2] += 1
        let end_pos[2] -= 1
    endif
    return ['v', start_pos, end_pos]
endfunction

function! s:select(object_type)
    let head = s:get_quotes(s:get_buffer_head())
    let opened = s:parse_quotes(head)

    " the inside case
    if len(opened) > 0
        let tail = s:get_quotes(s:get_buffer_tail())
        let first_closing = s:get_first_closing_quote(tail, opened)
        let regex = s:quote_regex(first_closing)
        call search(regex, 'Wbe')
        let start_pos = getpos('.')
        call search(regex, 'We')
        let end_pos = getpos('.')

        return s:format_output(a:object_type, start_pos, end_pos)
    endif

    " the in front case current line
    let regex_any = s:quote_regex('(''|\"|`)')
    let is_infront = search(regex_any, 'Wce', line('.'))
    if is_infront
        let quote = getline('.')[col('.') - 1]
        let start_pos = getpos('.')
        call search(s:quote_regex(quote), 'We')
        let end_pos = getpos('.')

        return s:format_output(a:object_type, start_pos, end_pos)
    else
        let is_behind = search(regex_any, 'Wbce', line('.'))
        " the behind case current line
        if is_behind
            let quote = getline('.')[col('.') - 1]
            let end_pos = getpos('.')
            call search(s:quote_regex(quote), 'Wbe')
            let start_pos = getpos('.')

            return s:format_output(a:object_type, start_pos, end_pos)
        endif
    endif

    " the in front case whole buffer
    let regex_any = s:quote_regex('(''|\"|`)')
    let is_infront = search(regex_any, 'Wce')
    if is_infront
        let quote = getline('.')[col('.') - 1]
        let start_pos = getpos('.')
        call search(s:quote_regex(quote), 'We')
        let end_pos = getpos('.')

        return s:format_output(a:object_type, start_pos, end_pos)
    else
        let is_behind = search(regex_any, 'Wbce')
        " the behind case whole buffer
        if is_behind
            let quote = getline('.')[col('.') - 1]
            let end_pos = getpos('.')
            call search(s:quote_regex(quote), 'Wbe')
            let start_pos = getpos('.')

            return s:format_output(a:object_type, start_pos, end_pos)
        endif
    endif

endfunction


function! s:select_a()
    return s:select('a')
endfunction


function! s:select_i()
    return s:select('i')
endfunction


let g:loaded_textobj_quotes = 1
