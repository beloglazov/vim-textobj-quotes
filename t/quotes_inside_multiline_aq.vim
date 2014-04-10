filetype plugin on
runtime! plugin/textobj/quotes.vim

describe 'inside multiline'

    before
        new
    end

    after
        close!
    end

    it 'simple'
        0 put =[
        \   '1\"2',
        \   '3\"4',
        \ ]
        normal! l
        normal daq
        Expect getline(1) == '14'
        Expect getline(2) == ''
    end

    it 'simple'
        0 put =[
        \   '1\"2',
        \   '3\"4',
        \ ]
        normal! ll
        normal daq
        Expect getline(1) == '14'
        Expect getline(2) == ''
    end

    it 'simple'
        0 put =[
        \   '1\"2',
        \   '3\"4',
        \ ]
        normal! j
        normal daq
        Expect getline(1) == '14'
        Expect getline(2) == ''
    end

    it 'simple'
        0 put =[
        \   '1\"2',
        \   '3\"4',
        \ ]
        normal! jl
        normal daq
        Expect getline(1) == '14'
        Expect getline(2) == ''
    end

    it 'simple'
        0 put =[
        \   '1\"2',
        \   '3\"4',
        \ ]
        normal! jll
        normal daq
        Expect getline(1) == '14'
        Expect getline(2) == ''
    end

end

