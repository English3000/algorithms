# https://leetcode.com/problems/word-ladder/description/
# Given two words (beginWord and endWord), and a dictionary's word list, find the length of shortest transformation sequence from beginWord to endWord, such that:
#
#    Only one letter can be changed at a time.
#    Each transformed word must exist in the word list. Note that beginWord is not a transformed word.

# Mine is a stricter version, where transformations must occur in sequential order in word list.
# only for 3-letter words
# for words of any length, do:
  # [['h',0],['a',1],['t',2]] - [['h',0],['i',1],['t',2]]
    # => [["a", 1]]
# checking whether return value's length is 1

# param {String} begin_word
# param {String} end_word
# param {String[]} word_list
# return {Fixnum}
def ladder_length(begin_word, end_word, word_list)
    return 0 unless word_list.include?(end_word)
    # create list of possible transformations from start word
    current_word = begin_word
    possible_next_words = []
    word_list.each_with_index do |word, i|
        if word != current_word && (word[0..1] == current_word[0..1] || word[1..2] == current_word[1..2] ||
                (word[0] == current_word[0] && word[2] == current_word[2]))
            possible_next_words.push([word, i, 2])
        end
    end

    until possible_next_words.any?{|word_array| word_array.class == Integer} #b/c first time a Fixnum appears is the shortest path
        return 0 if possible_next_words.empty? || possible_next_words[0][1] == word_list.length - 1 && possible_next_words[0][0] != end_word
        possible_next_words.concat(transform(possible_next_words.shift, word_list, end_word))
    end

    possible_next_words.select{|word_array| word_array.class == Integer}.first
end

def transform(current_word_array, word_list, end_word)
    # p current_word_array
    # return [current_word_array] if current_word_array.class == Integer
    return [current_word_array[2]] if current_word_array[0] == end_word
    possible_next_words = []
    current_word = current_word_array[0]
    word_list.each_with_index do |word, i|
        if current_word_array[1] < i && word[0..1] == current_word[0..1] || word[1..2] == current_word[1..2] || (word[0] == current_word[0] && word[2] == current_word[2])

           possible_next_words.push([word, i, current_word_array[2] + 1])
        end
    end

    possible_next_words
end

ladder_length("hit","cog",["hot","dot","dog","lot","log","cog"])
