require_relative "heap"

class Array
  def heap_sort!
    return self if self == self.sort

    prc = Proc.new { |el1, el2| -1 * (el1 <=> el2) }
    sorter = length - 1

    until sorter == 0
      old_self = self.dup
      BinaryMinHeap.heapify_up(self, sorter, &prc)
      sorter -= 1 if old_self == self.dup
    end

    sorter = length - 1
    until sorter == 0
      self[0], self[sorter] = self[sorter], self[0]
      self[0...sorter] = BinaryMinHeap.heapify_down(self[0...sorter], 0, &prc) #for some reason, swaps don't auto-register
      sorter -= 1
    end

    self

    # heap = BinaryMinHeap.new(&prc)
    # heap.store = self

    # (length-1).times do |num|
      # old_store = heap.store.dup
      # heap.push(heap.store[0..length-1 - num].pop) #e.g. [1,2,3,4,1]
      # break if heap.store == old_store
    # end

    # until heap.count == 0
      # heap.extract
    # end

    # heap.store
  end
end
