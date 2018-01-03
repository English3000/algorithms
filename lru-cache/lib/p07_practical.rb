require_relative 'p05_hash_map'

def can_string_be_palindrome?(string)
  pal_map = HashMap.new

  string.each_char do |ch|
    freq = pal_map.get(ch)
    freq ? pal_map.set(ch, freq + 1) : pal_map.set(ch, 1)
  end

  odds = 0
  pal_map.each do |ch, freq|
    odds += 1 if freq % 2 == 1
  end
  odds > 1 ? false : true
end
