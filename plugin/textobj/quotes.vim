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
    return '\v([^\\]|^)\zs' . a:quote
endfunction

function! s:count_quotes(quote, content)
    let s:content = substitute(
        \ a:content, '\v\\' . a:quote, '', 'g')
    return strlen(substitute(
        \ s:content, '[^' . a:quote . ']', '', 'g'))
endfunction

function! s:select(object_type)
    let s:regex = s:quote_regex('(''|\"|`)')
    let s:pos = getpos('.')
    let s:line = line('.')
    let s:content = getline('.')
    let s:found = 0
    let s:start_found = search(s:regex, 'be', s:line)
    if s:start_found > 0
        let s:start_position = getpos('.')
        let s:q = s:content[col('.') - 1]
        let s:col = col('.')
        let s:content_head = s:content[: s:col - 1]
        let s:content_tail = s:content[s:col :]
        let s:head_cnt = s:count_quotes(s:q, s:content_head)
        let s:tail_cnt = s:count_quotes(s:q, s:content_tail)
        if s:head_cnt % 2 == 1 || s:tail_cnt == 0
            if s:tail_cnt == 0
                call search(s:quote_regex(s:q), 'be', s:line)
                let s:start_position = getpos('.')
            endif
            call search(s:quote_regex(s:q), 'e', s:line)
            let s:end_position = getpos('.')
            let s:found = 1
        endif
    endif

    if s:found == 0
        call setpos('.', s:pos)
        let s:start_found = search(s:regex, 'ce', s:line)
        if s:start_found > 0
            let s:start_position = getpos('.')
            let s:q = s:content[col('.') - 1]
            call search(s:quote_regex(s:q), 'e', s:line)
            let s:end_position = getpos('.')
            let s:found = 1
        endif
    endif

    if s:found == 0 || s:start_position == s:end_position
        return 0
    endif

    if a:object_type ==? 'i'
        let s:start_position[2] += 1
        let s:end_position[2] -= 1
    endif

    return ['v', s:start_position, s:end_position]
endfunction


function! s:select_a()
    return s:select('a')
endfunction


function! s:select_i()
    return s:select('i')
endfunction


let g:loaded_textobj_quotes = 1
