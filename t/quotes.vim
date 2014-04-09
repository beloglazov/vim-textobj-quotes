filetype plugin on
runtime! plugin/textobj/quotes.vim


describe 'iq (single quotes)'

    before
        new
        put! = 'foo ''1, 2, 3'' bar'
    end

    after
        close!
    end

    it 'deletes when inside'
        normal! 9|
        normal diq
        Expect getline(1) == "foo '' bar"
    end

    it 'deletes when in front'
        normal! 2|
        normal diq
        Expect getline(1) == "foo '' bar"
    end

    it 'deletes when behind'
        normal! 14|
        normal diq
        Expect getline(1) == "foo '' bar"
    end

end

describe 'iq with escaped quotes (single quotes)'

    before
        new
        put! = 'foo ''1, \''2\'', 3'' bar'
    end

    after
        close!
    end

    it 'deletes when inside'
        normal! 9|
        normal diq
        Expect getline(1) == "foo '' bar"
    end

    it 'deletes when in front'
        normal! 2|
        normal diq
        Expect getline(1) == "foo '' bar"
    end

    it 'deletes when behind'
        normal! 14|
        normal diq
        Expect getline(1) == "foo '' bar"
    end

end

describe 'iq with escaped quotes complex (single quotes)'

    before
        new
        put! = '\''foo ''1, \''2\'', 3'' bar\'''
    end

    after
        close!
    end

    it 'deletes when inside'
        normal! 9|
        normal diq
        Expect getline(1) == "\\'foo '' bar\\'"
    end

    it 'deletes when in front'
        normal! 2|
        normal diq
        Expect getline(1) == "\\'foo '' bar\\'"
    end

    it 'deletes when behind'
        normal! 14|
        normal diq
        Expect getline(1) == "\\'foo '' bar\\'"
    end

end

describe 'iq (double quotes)'

    before
        new
        put! = 'foo \"1, 2, 3\" bar'
    end

    after
        close!
    end

    it 'deletes when inside'
        normal! 9|
        normal diq
        Expect getline(1) == 'foo "" bar'
    end

    it 'deletes when in front'
        normal! 2|
        normal diq
        Expect getline(1) == 'foo "" bar'
    end

    it 'deletes when behind'
        normal! 14|
        normal diq
        Expect getline(1) == 'foo "" bar'
    end

end

describe 'iq with escaped quotes (double quotes)'

    before
        new
        put! = 'foo \"1, \\"2\\", 3\" bar'
    end

    after
        close!
    end

    it 'deletes when inside'
        normal! 9|
        normal diq
        Expect getline(1) == 'foo "" bar'
    end

    it 'deletes when in front'
        normal! 2|
        normal diq
        Expect getline(1) == 'foo "" bar'
    end

    it 'deletes when behind'
        normal! 14|
        normal diq
        Expect getline(1) == 'foo "" bar'
    end

end

describe 'iq (back quotes)'

    before
        new
        put! = 'foo `1, 2, 3` bar'
    end

    after
        close!
    end

    it 'deletes when inside'
        normal! 9|
        normal diq
        Expect getline(1) == 'foo `` bar'
    end

    it 'deletes when in front'
        normal! 2|
        normal diq
        Expect getline(1) == 'foo `` bar'
    end

    it 'deletes when behind'
        normal! 14|
        normal diq
        Expect getline(1) == 'foo `` bar'
    end

end

describe 'iq with escaped quotes (back quotes)'

    before
        new
        put! = 'foo `1, \`2\`, \\"3\\"` bar'
    end

    after
        close!
    end

    it 'deletes when inside'
        normal! 9|
        normal diq
        Expect getline(1) == 'foo `` bar'
    end

    it 'deletes when in front'
        normal! 2|
        normal diq
        Expect getline(1) == 'foo `` bar'
    end

    it 'deletes when behind'
        normal! 14|
        normal diq
        Expect getline(1) == 'foo `` bar'
    end

end

describe 'aq (single quotes)'

    before
        new
        put! = 'foo ''1, 2, 3'' bar'
    end

    after
        close!
    end

    it 'deletes when inside'
        normal! 9|
        normal daq
        Expect getline(1) == "foo  bar"
    end

    it 'deletes when in front'
        normal! 2|
        normal daq
        Expect getline(1) == "foo  bar"
    end

    it 'deletes when behind'
        normal! 14|
        normal daq
        Expect getline(1) == "foo  bar"
    end

end

describe 'aq with escaped quotes (single quotes)'

    before
        new
        put! = 'foo ''1, \''2\'', 3'' bar'
    end

    after
        close!
    end

    it 'deletes when inside'
        normal! 9|
        normal daq
        Expect getline(1) == "foo  bar"
    end

    it 'deletes when in front'
        normal! 2|
        normal daq
        Expect getline(1) == "foo  bar"
    end

    it 'deletes when behind'
        normal! 14|
        normal daq
        Expect getline(1) == "foo  bar"
    end

end

describe 'aq (double quotes)'

    before
        new
        put! = 'foo \"1, 2, 3\" bar'
    end

    after
        close!
    end

    it 'deletes when inside'
        normal! 9|
        normal daq
        Expect getline(1) == 'foo  bar'
    end

    it 'deletes when in front'
        normal! 2|
        normal daq
        Expect getline(1) == 'foo  bar'
    end

    it 'deletes when behind'
        normal! 14|
        normal daq
        Expect getline(1) == 'foo  bar'
    end

end

describe 'aq with escaped quotes (double quotes)'

    before
        new
        put! = 'foo \"1, \\"2\\", 3\" bar'
    end

    after
        close!
    end

    it 'deletes when inside'
        normal! 9|
        normal daq
        Expect getline(1) == 'foo  bar'
    end

    it 'deletes when in front'
        normal! 2|
        normal daq
        Expect getline(1) == 'foo  bar'
    end

    it 'deletes when behind'
        normal! 14|
        normal daq
        Expect getline(1) == 'foo  bar'
    end

end

describe 'aq (back quotes)'

    before
        new
        put! = 'foo `1, 2, 3` bar'
    end

    after
        close!
    end

    it 'deletes when inside'
        normal! 9|
        normal daq
        Expect getline(1) == 'foo  bar'
    end

    it 'deletes when in front'
        normal! 2|
        normal daq
        Expect getline(1) == 'foo  bar'
    end

    it 'deletes when behind'
        normal! 14|
        normal daq
        Expect getline(1) == 'foo  bar'
    end

end

describe 'aq with escaped quotes (back quotes)'

    before
        new
        put! = 'foo `1, \`2\`, \\"3\\"` bar'
    end

    after
        close!
    end

    it 'deletes when inside'
        normal! 9|
        normal daq
        Expect getline(1) == 'foo  bar'
    end

    it 'deletes when in front'
        normal! 2|
        normal daq
        Expect getline(1) == 'foo  bar'
    end

    it 'deletes when behind'
        normal! 14|
        normal daq
        Expect getline(1) == 'foo  bar'
    end

end

