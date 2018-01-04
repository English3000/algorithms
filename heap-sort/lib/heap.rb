class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
    @store = []
    @prc = prc
  end

  def count
    @store.length
  end

  def extract
    raise 'empty' if count == 0

    @store[count - 1], @store[0] = @store[0], @store[count - 1]
    return_value = @store.pop

    BinaryMinHeap.heapify_down(@store, 0, &@prc)
    return_value
  end

  def peek
    raise 'empty' if count == 0

    @store[0]
  end

  def push(val)
    @store.push(val)

    BinaryMinHeap.heapify_up(@store, count - 1, &@prc)
  end

  public
  def self.child_indices(len, parent_index)
    if len <= 2 * parent_index + 1
      []
    elsif len == 2 * parent_index + 2
      [2 * parent_index + 1]
    else
      [2 * parent_index + 1, 2 * parent_index + 2]
    end
  end

  def self.parent_index(child_index)
    raise 'root has no parent' if child_index == 0
    (child_index - 1) / 2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    children_i = child_indices(len, parent_idx)

    unless prc
      until children_i == [] ||
        array[parent_idx] < array[children_i[0]] &&
        (!children_i[1] || array[parent_idx] < array[children_i[1]])

        child_i = (!children_i[1] || array[children_i[0]] <= array[children_i[1]]) ?
          children_i[0] : children_i[1]

        array[parent_idx], array[child_i] = array[child_i], array[parent_idx]
        parent_idx = child_i
        children_i = child_indices(array.count, parent_idx)
      end
    else
      until children_i == [] || prc.call(array[parent_idx], array[children_i[0]]) != 1 &&
        (!children_i[1] || prc.call(array[parent_idx], array[children_i[1]]) != 1)

        if children_i[1]
          child_i = prc.call(array[children_i[0]], array[children_i[1]])
          case child_i
          when 1
            child_i = children_i[1]
          else
            child_i = children_i[0]
          end
        else
          child_i = children_i[0]
        end

        swap = prc.call(array[parent_idx], array[child_i])
        case swap
        when 1
          array[parent_idx], array[child_i] = array[child_i], array[parent_idx]
          parent_idx = child_i
          children_i = child_indices(array.count, parent_idx)
        else
          return array
        end
      end
    end
    array
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    return array if child_idx == 0
    parent_i = parent_index(child_idx)

    unless prc
      until child_idx == 0 || array[child_idx] >= array[parent_i]
        array[child_idx], array[parent_i] = array[parent_i], array[child_idx]
        child_idx = parent_i
        parent_i = parent_index(child_idx) unless child_idx == 0
      end
    else
      until child_idx == 0 || prc.call(array[child_idx], array[parent_i]) != -1
        array[child_idx], array[parent_i] = array[parent_i], array[child_idx]
        child_idx = parent_i
        parent_i = parent_index(child_idx) unless child_idx == 0
      end
    end
    array
  end
end
