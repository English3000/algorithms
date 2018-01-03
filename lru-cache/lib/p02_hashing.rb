class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    sum = 0
    each_with_index do |num, el|
      num = 2017 if num == []
      sum += num * 2017**el
    end
    sum.hash
  end
end

class String
  def hash
    arr = chars.map { |ch| ch.ord ** 2 * 2017 }
    arr.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    values.sort.map do |el|
      el.hash
    end.hash
  end
end
