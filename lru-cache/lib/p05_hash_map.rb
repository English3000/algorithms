require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  include Enumerable

  attr_reader :count, :store

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    num = key.hash
    bucket = @store[num % num_buckets]
    bucket.include?(key)
  end

  def set(key, val)
    num = key.hash
    bucket = @store[num % num_buckets]
    if bucket.include?(key)
      bucket.update(key, val)
    else
      @count += 1
      resize! if @count == num_buckets
      bucket.append(key, val)
    end
  end

  def get(key)
    num = key.hash
    bucket = @store[num % num_buckets]
    bucket.get(key)
  end

  def delete(key)
    num = key.hash
    bucket = @store[num % num_buckets]

    removed = bucket.remove(key)
    @count -= 1 if removed
    removed
  end

  def each(&block)
    @store.each do |bucket|
      bucket.each do |node|
        block.call(node.key, node.val)
      end
    end
  end

  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    new_hashmap = HashMap.new(num_buckets * 2)
    @store.each do |bucket|
      bucket.each do |node|
        new_hashmap.set(node.key, node.val)
      end
    end
    @store = new_hashmap.store
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
  end
end
