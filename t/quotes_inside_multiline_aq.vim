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
        normal! f1
        normal daq
        Expect getline(1) == '14'
        Expect getline(2) == ''
    end

    it 'simple'
        0 put =[
        \   '1\"2',
        \   '3\"4',
        \ ]
        normal! f"
        normal daq
        Expect getline(1) == '14'
        Expect getline(2) == ''
    end

    it 'simple'
        0 put =[
        \   '1\"2',
        \   '3\"4',
        \ ]
        normal! f2
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
        normal! jf"
        normal daq
        Expect getline(1) == '14'
        Expect getline(2) == ''
    end

    it 'simple'
        0 put =[
        \   '1\"2',
        \   '3\"4',
        \ ]
        normal! jf4
        normal daq
        Expect getline(1) == '14'
        Expect getline(2) == ''
    end

end

