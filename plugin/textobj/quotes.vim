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
" return '\v([^\\]|^)\zs' . a:quote
" return '\v[^\\]\zs' . a:quote
    return '\v(\\)@<!' . a:quote
endfunction

function! s:get_quotes(str)
    let unescaped = substitute(a:str, '\v\\+(''|"|`)', '', 'g')
    return substitute(unescaped, '\v[^''"`]', '', 'g')
endfunction

function! s:count_quotes(quote, content)
    let s:content = substitute(
        \ a:content, '\v\\' . a:quote, '', 'g')
    return strlen(substitute(
        \ s:content, '[^' . a:quote . ']', '', 'g'))
endfunction

function! s:get_buffer_head()
    let s:col = col('.')
    let lines = getline(0, '.')
    let lines[-1] = lines[-1][: s:col - 2]
    return join(lines, "\n")
endfunction

function! s:get_buffer_tail()
    let s:col = col('.')
    let lines = getline('.', '$')
    let lines[0] = lines[0][s:col - 1 :]
    return join(lines, "\n")
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
    " echom 'Opened: ' . join(opened, ', ')
    return opened
    " if len(opened) > 0
    "     return opened[-1]
    " else
    "     return ''
    " endif
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

" echom s:parse_quotes('"')
" echom s:parse_quotes('""')
" echom s:parse_quotes('"''"')
" echom s:parse_quotes('"''"''')
" echom s:parse_quotes('"''"''"')
" echom s:parse_quotes('"''``')
" echom s:parse_quotes('"''``''')
" echom s:get_quotes('qwe "asd''`\`\"''')

" delete escaped quotes: %s/\v\\+('|"|`)//


function! s:select(object_type)
    let head = s:get_quotes(s:get_buffer_head())
    let tail = s:get_quotes(s:get_buffer_tail())
    let opened = s:parse_quotes(head)
    " echom 'head: ' . head
    " echom 'tail: ' . tail
    " echom 'opened: ' . join(opened, ', ')

    " the inside case
    if len(opened) > 0
        " echom 'INSIDE'
        let first_closing = s:get_first_closing_quote(tail, opened)
        " echom 'first closing: ' . first_closing
        let regex = s:quote_regex(first_closing)
        " echom regex
        call search(regex, 'Wbe')
        let start_pos = getpos('.')
        " echom join(start_pos, ', ')
        call search(regex, 'We')
        let end_pos = getpos('.')
        " echom join(end_pos, ', ')

        if a:object_type ==? 'i'
            let start_pos[2] += 1
            let end_pos[2] -= 1
        endif

        return ['v', start_pos, end_pos]
    endif

    " the in front case current line
    let regex_any = s:quote_regex('(''|\"|`)')
    let is_infront = search(regex_any, 'Wce', line('.'))
    if is_infront
        " echom 'IN FRONT'
        let quote = getline('.')[col('.') - 1]
        " echom 'quote: ' . quote
        let start_pos = getpos('.')
        " echom join(start_pos, ', ')
        call search(s:quote_regex(quote), 'We')
        let end_pos = getpos('.')
        " echom join(end_pos, ', ')

        if a:object_type ==? 'i'
            let start_pos[2] += 1
            let end_pos[2] -= 1
        endif

        return ['v', start_pos, end_pos]
    else
        let is_behind = search(regex_any, 'Wbce', line('.'))
        " the behind case current line
        if is_behind
            " echom 'BEHIND'
            let quote = getline('.')[col('.') - 1]
            " echom 'quote: ' . quote
            let end_pos = getpos('.')
            " echom join(end_pos, ', ')
            call search(s:quote_regex(quote), 'Wbe')
            let start_pos = getpos('.')
            " echom join(start_pos, ', ')

            if a:object_type ==? 'i'
                let start_pos[2] += 1
                let end_pos[2] -= 1
            endif

            return ['v', start_pos, end_pos]
        endif
    endif

    " the in front case whole buffer
    let regex_any = s:quote_regex('(''|\"|`)')
    let is_infront = search(regex_any, 'Wce')
    if is_infront
        " echom 'IN FRONT'
        let quote = getline('.')[col('.') - 1]
        " echom 'quote: ' . quote
        let start_pos = getpos('.')
        " echom join(start_pos, ', ')
        call search(s:quote_regex(quote), 'We')
        let end_pos = getpos('.')
        " echom join(end_pos, ', ')

        if a:object_type ==? 'i'
            let start_pos[2] += 1
            let end_pos[2] -= 1
        endif

        return ['v', start_pos, end_pos]
    else
        let is_behind = search(regex_any, 'Wbce')
        " the behind case whole buffer
        if is_behind
            " echom 'BEHIND'
            let quote = getline('.')[col('.') - 1]
            " echom 'quote: ' . quote
            let end_pos = getpos('.')
            " echom join(end_pos, ', ')
            call search(s:quote_regex(quote), 'Wbe')
            let start_pos = getpos('.')
            " echom join(start_pos, ', ')

            if a:object_type ==? 'i'
                let start_pos[2] += 1
                let end_pos[2] -= 1
            endif

            return ['v', start_pos, end_pos]
        endif
    endif

endfunction

function! s:select2(object_type)
    let s:regex = s:quote_regex('(''|\"|`)')
    let s:pos = getpos('.')
    let s:line = line('.')
    let s:content = getline('.')
    let s:found = 0
    let s:start_found = search(s:regex, 'be', s:line)
    echom 'start found: ' . s:start_found
    if s:start_found > 0
        let s:start_position = getpos('.')
        echom 'start position: ' . s:start_position[2]
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
        let s:start_found = search(s:regex, 'be')
        echom s:start_found
        if s:start_found > 0
            let s:start_position = getpos('.')
            let s:q = s:content[col('.') - 1]
            let s:col = col('.')
            " let s:content_head = s:content[: s:col - 1]
            " let s:content_tail = s:content[s:col :]
            " let s:head_cnt = s:count_quotes(s:q, s:content_head)
            let s:head_cnt = s:count_quotes(s:q, s:get_buffer_head())
            " let s:tail_cnt = s:count_quotes(s:q, s:content_tail)
            let s:tail_cnt = s:count_quotes(s:q, s:get_buffer_tail())
            if s:head_cnt % 2 == 1 || s:tail_cnt == 0
                if s:tail_cnt == 0
                    " call search(s:quote_regex(s:q), 'be', s:line)
                    call search(s:quote_regex(s:q), 'be')
                    let s:start_position = getpos('.')
                endif
                " call search(s:quote_regex(s:q), 'e', s:line)
                call search(s:quote_regex(s:q), 'e')
                let s:end_position = getpos('.')
                let s:found = 1
            endif
        endif

        if s:found == 0
            call setpos('.', s:pos)
            " let s:start_found = search(s:regex, 'ce', s:line)
            let s:start_found = search(s:regex, 'ce')
            if s:start_found > 0
                let s:start_position = getpos('.')
                let s:q = s:content[col('.') - 1]
                " call search(s:quote_regex(s:q), 'e', s:line)
                call search(s:quote_regex(s:q), 'e')
                let s:end_position = getpos('.')
                let s:found = 1
            endif
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
