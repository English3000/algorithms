require_relative 'p02_hashing'

class HashSet
  attr_reader :count, :store

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    num = key.hash
    @count += 1
    resize! if @count == num_buckets
    @store[num % num_buckets].push(num)
  end

  def include?(key)
    num = key.hash
    @store[num % num_buckets].include?(num)
  end

  def remove(key)
    num = key.hash
    @count -= 1
    @store[num % num_buckets].delete(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_set = HashSet.new(@count * 2)
    @store.each do |bucket|
      bucket.each do |num|
        new_set.insert(num)
      end
    end
    @store = new_set.store
  end
end
