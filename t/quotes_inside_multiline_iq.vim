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
        normal diq
        Expect getline(1) == '1""4'
        Expect getline(2) == ''
    end

    it 'simple'
        0 put =[
        \   '1\"2',
        \   '3\"4',
        \ ]
        normal! f"
        normal diq
        Expect getline(1) == '1""4'
        Expect getline(2) == ''
    end

    it 'simple'
        0 put =[
        \   '1\"2',
        \   '3\"4',
        \ ]
        normal! f2
        normal diq
        Expect getline(1) == '1""4'
        Expect getline(2) == ''
    end

    it 'simple'
        0 put =[
        \   '1\"2',
        \   '3\"4',
        \ ]
        normal! j
        normal diq
        Expect getline(1) == '1""4'
        Expect getline(2) == ''
    end

    it 'simple'
        0 put =[
        \   '1\"2',
        \   '3\"4',
        \ ]
        normal! jf"
        normal diq
        Expect getline(1) == '1""4'
        Expect getline(2) == ''
    end

    it 'simple'
        0 put =[
        \   '1\"2',
        \   '3\"4',
        \ ]
        normal! jf4
        normal diq
        Expect getline(1) == '1""4'
        Expect getline(2) == ''
    end

end

