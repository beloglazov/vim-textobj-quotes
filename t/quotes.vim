filetype plugin on
runtime! plugin/textobj/quotes.vim


describe 'iq'
    it 'selects when inside single quotes'
        put! = "foo '1, 2, 3' bar"
        normal! 9|
        normal diq
        Expect getline(1) == "foo '' bar"
    end

    it 'selects when in front of single quotes'
        put! = "foo '1, 2, 3' bar"
        normal! 2|
        normal diq
        Expect getline(1) == "foo '' bar"
    end

    it 'selects when behind single quotes'
        put! = "foo '1, 2, 3' bar"
        normal! 14|
        normal diq
        Expect getline(1) == "foo '' bar"
    end
end
