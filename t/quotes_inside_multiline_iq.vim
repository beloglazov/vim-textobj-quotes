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
        normal diq
        Expect getline(1) == '1""4'
        Expect getline(2) == ''
    end

    it 'simple'
        0 put =[
        \   '1\"2',
        \   '3\"4',
        \ ]
        normal! ll
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
        normal! jl
        normal diq
        Expect getline(1) == '1""4'
        Expect getline(2) == ''
    end

    it 'simple'
        0 put =[
        \   '1\"2',
        \   '3\"4',
        \ ]
        normal! jll
        normal diq
        Expect getline(1) == '1""4'
        Expect getline(2) == ''
    end

end

