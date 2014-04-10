filetype plugin on
runtime! plugin/textobj/quotes.vim

describe 'ignore vimscript comments'

    before
        new
        set filetype=vim
    end

    after
        close!
    end

    it 'simple'
        put! = '\" 1 \"2\" 3'
        normal diq
        Expect getline(1) == '" 1 "" 3'
    end

    it 'simple'
        put! = '\" 1 \"2\" 3'
        normal! f1
        normal diq
        Expect getline(1) == '" 1 "" 3'
    end

    it 'simple'
        put! = '\" 1 \"2\" 3'
        normal! f2
        normal diq
        Expect getline(1) == '" 1 "" 3'
    end

    it 'simple'
        put! = '\" 1 \"2\" 3'
        normal! f3
        normal diq
        Expect getline(1) == '" 1 "" 3'
    end

    it 'double comment quote'
        put! = '\"\" 1 \"2\" 3'
        normal diq
        Expect getline(1) == '"" 1 "" 3'
    end

    it 'double comment quote'
        put! = '\"\" 1 \"2\" 3'
        normal! f1
        normal diq
        Expect getline(1) == '"" 1 "" 3'
    end

    it 'double comment quote'
        put! = '\"\" 1 \"2\" 3'
        normal! f2
        normal diq
        Expect getline(1) == '"" 1 "" 3'
    end

    it 'double comment quote'
        put! = '\"\" 1 \"2\" 3'
        normal! f3
        normal diq
        Expect getline(1) == '"" 1 "" 3'
    end

end
