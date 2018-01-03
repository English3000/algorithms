class MaxIntSet
  def initialize(max)
    @store = Array.new(max+1) {false}
  end

  def insert(num)
    validate!(num)
    @store[num-1] = true
  end

  def remove(num)
    validate!(num)
    @store[num-1] = false
  end

  def include?(num)
    @store[num-1]
  end

  private

  def is_valid?(num)
  end

  def validate!(num)
    raise 'Out of bounds' if num < 0 || num >= @store.length || num.class == Float
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    @store[num % num_buckets].push(num)
  end

  def remove(num)
    @store[num % num_buckets].delete(num)
  end

  def include?(num)
    @store[num % num_buckets].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count, :store

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    @count += 1
    resize! if @count == num_buckets
    @store[num % num_buckets].push(num)
  end

  def remove(num)
    @count -= 1
    @store[num % num_buckets].delete(num)
  end

  def include?(num)
    @store[num % num_buckets].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_set = ResizingIntSet.new(@count * 2)
    @store.each do |bucket|
      bucket.each do |num|
        new_set.insert(num)
      end
    end
    @store = new_set.store
  end
end
