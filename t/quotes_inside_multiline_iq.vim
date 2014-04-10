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

    it 'three lines, closing at the beginning of a line'
        0 put =[
        \   'hello = \"',
        \   'world',
        \   '\"',
        \ ]
        normal diq
        Expect getline(1) == 'hello = ""'
        Expect getline(2) == ''
        Expect getline(3) == ''
    end

    it 'three lines, closing at the beginning of a line'
        0 put =[
        \   'hello = \"',
        \   'world',
        \   '\"',
        \ ]
        normal! j
        normal diq
        Expect getline(1) == 'hello = ""'
        Expect getline(2) == ''
        Expect getline(3) == ''
    end

    it 'three lines, closing not at the beginning of a line'
        0 put =[
        \   'hello = \"',
        \   'world',
        \   '!\"',
        \ ]
        normal diq
        Expect getline(1) == 'hello = ""'
        Expect getline(2) == ''
        Expect getline(3) == ''
    end

    it 'three lines, closing not at the beginning of a line'
        0 put =[
        \   'hello = \"',
        \   'world',
        \   '!\"',
        \ ]
        normal! j
        normal diq
        Expect getline(1) == 'hello = ""'
        Expect getline(2) == ''
        Expect getline(3) == ''
    end

end

