filetype plugin on
runtime! plugin/textobj/quotes.vim

describe 'inside'

    before
        new
    end

    after
        close!
    end

    it 'simple'
        put! = '\"qwe\"'
        normal! f"
        normal diq
        Expect getline(1) == '""'
    end

    it 'simple'
        put! = '\"qwe\"'
        normal! fq
        normal diq
        Expect getline(1) == '""'
    end

    it 'simple'
        put! = '\"qwe\"'
        normal! fw
        normal diq
        Expect getline(1) == '""'
    end

    it 'simple'
        put! = '\"qwe\"'
        normal! f";
        normal diq
        Expect getline(1) == '""'
    end

    it 'apostrophe'
        put! = '\"1 '' 2\"'
        normal! f1
        normal diq
        Expect getline(1) == '""'
    end

    it 'apostrophe'
        put! = '\"1 '' 2\"'
        normal! f'
        normal diq
        Expect getline(1) == '""'
    end

    it 'apostrophe'
        put! = '\"1 '' 2\"'
        normal! f2
        normal diq
        Expect getline(1) == '""'
    end

    it 'escaped'
        put! = '\"1 \\" 2\"'
        normal! f1
        normal diq
        Expect getline(1) == '""'
    end

    it 'escaped'
        put! = '\"1 \\" 2\"'
        normal! f2
        normal diq
        Expect getline(1) == '""'
    end

    it 'escaped 2'
        put! = '\\"1 \" 2\"'
        normal! f1
        normal diq
        Expect getline(1) == '\"1 ""'
    end

    it 'escaped 2'
        put! = '\\"1 \" 2\"'
        normal! f2
        normal diq
        Expect getline(1) == '\"1 ""'
    end

    it 'nested'
        put! = '\"1 '' 2 `3` 4 '' 5\"'
        normal! f1
        normal diq
        Expect getline(1) == '""'
    end

    it 'nested'
        put! = '\"1 '' 2 `3` 4 '' 5\"'
        normal! f2
        normal diq
        Expect getline(1) == '"1 '''' 5"'
    end

    it 'nested'
        put! = '\"1 '' 2 `3` 4 '' 5\"'
        normal! f3
        normal diq
        Expect getline(1) == '"1 '' 2 `` 4 '' 5"'
    end

    it 'nested'
        put! = '\"1 '' 2 `3` 4 '' 5\"'
        normal! f4
        normal diq
        Expect getline(1) == '"1 '''' 5"'
    end

    it 'nested'
        put! = '\"1 '' 2 `3` 4 '' 5\"'
        normal! f5
        normal diq
        Expect getline(1) == '""'
    end

    it 'nested 2'
        put! = '\"1 '' 2 `3` 4 '' 5 '' 6 '' 7\"'
        normal! f1
        normal diq
        Expect getline(1) == '""'
    end

    it 'nested 2'
        put! = '\"1 '' 2 `3` 4 '' 5 '' 6 '' 7\"'
        normal! f2
        normal diq
        Expect getline(1) == '"1 '''' 5 '' 6 '' 7"'
    end

    it 'nested 2'
        put! = '\"1 '' 2 `3` 4 '' 5 '' 6 '' 7\"'
        normal! f3
        normal diq
        Expect getline(1) == '"1 '' 2 `` 4 '' 5 '' 6 '' 7"'
    end

    it 'nested 2'
        put! = '\"1 '' 2 `3` 4 '' 5 '' 6 '' 7\"'
        normal! f4
        normal diq
        Expect getline(1) == '"1 '''' 5 '' 6 '' 7"'
    end

    it 'nested 2'
        put! = '\"1 '' 2 `3` 4 '' 5 '' 6 '' 7\"'
        normal! f5
        normal diq
        Expect getline(1) == '""'
    end

    it 'nested 2'
        put! = '\"1 '' 2 `3` 4 '' 5 '' 6 '' 7\"'
        normal! f6
        normal diq
        Expect getline(1) == '"1 '' 2 `3` 4 '' 5 '''' 7"'
    end

    it 'nested 2'
        put! = '\"1 '' 2 `3` 4 '' 5 '' 6 '' 7\"'
        normal! f7
        normal diq
        Expect getline(1) == '""'
    end

end
