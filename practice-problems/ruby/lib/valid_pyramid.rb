# https://leetcode.com/problems/pyramid-transition-matrix/description/
# We are stacking blocks to form a pyramid. Each block has a color which is a one letter string, like `'Z'`.
# For every block of color `C` we place not in the bottom row, we are placing it on top of a left block of color `A` and right block of color `B`. We are allowed to place the block there only if `(A, B, C)` is an allowed triple.
# We start with a bottom row of bottom, represented as a single string. We also start with a list of allowed triples allowed. Each allowed triple is represented as a string of length 3.
# Return true if we can build the pyramid all the way to the top, otherwise false.

# param {String} bottom
# param {String[]} allowed
# return {Boolean}
def pyramid_transition(bottom, allowed)
    #size = bottom.length + bottom.length - 1 ... + 1
    possible_rows = [bottom]
    next_rows = [""]
    while true
      old_rows = possible_rows.dup
      possible_rows.each do |row| #to allow for multiple possible pyramids
          row.chars.each_index do |idx| #b/c order matters in creating the pyramid
              next if idx == row.length - 1
              old_length = next_rows.length
              allowed.each do |str|
                  if row[idx..idx+1] == str[0..1] #or check for inclusion of two??
                      next_rows.concat(next_rows[0...old_length])
                      (-1 * old_length..-1).each{|idx| next_rows[idx] += str[2]}
                      # p next_rows
                  end
              end
              old_length.times{next_rows.shift}
              # puts "Shifted: #{next_rows}"
          end #bug = resetting possible_rows rather than appending to it
          possible_rows += next_rows.select{|next_row| next_row.length == possible_rows[0].length - 1}
          possible_rows.delete(row)
          # puts "Possible: #{possible_rows}"
          return false if possible_rows.empty? #|| possible_rows == old_rows
          return true if possible_rows[-1].length == 1
          next_rows = [""]
      end
    end
end

# pyramid_transition("ABC", ["ABD","BCE","DEF","FFF"])
# pyramid_transition("CCC", ["CCB", "CCA"])
