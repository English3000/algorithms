class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    left = []
    right = []
    pivot = array[0]
    1.upto(length) do |i|
      case pivot <=> array[i]
      when 1
        left.push(array[i])
      else
        right.push(array[i])
      end
    end
    QuickSort.sort1(left) + [pivot] + QuickSort.sort1(right)
  end

  # In-place. //select pivot randomly; space complexity of O(log n)--the recursive call stack--making it most usable
  # OR, pass in full array on recursive calls & change start & length
  def self.sort2!(array, start = 0, length = array.length, &prc)
    return array if length <= 1

    prc ||= Proc.new { |el1, el2| el1 <=> el2 }

    pivot = QuickSort.partition(array, start, length - start, &prc)

    unless pivot == 0
      # p 'slice 1'
      # p array[0..pivot-1] = QuickSort.sort2!(array[0..pivot-1], rand(0...pivot-1), &prc)
      array[0..pivot-1] = QuickSort.sort2!(array[0..pivot-1], rand(0...pivot-1), &prc)
    end

    unless pivot == length - 1
      # p 'slice 2'
      # p array[pivot+1...length] = QuickSort.sort2!(array[pivot+1...length], rand(0...length - (pivot+1)), &prc)
      array[pivot+1...length] = QuickSort.sort2!(array[pivot+1...length], rand(0...length - (pivot+1)), &prc)
    end
    # p array
    array
  end

  def self.partition(array, start, length, &prc)
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }

    counter = start + 1
    counter.upto(counter + length-2) do |i|
      case prc.call(array[start], array[i])
      when 1 || 0
        array[i], array[counter] = array[counter], array[i]
        counter += 1
      end
    end

    array[start], array[counter-1] = array[counter-1], array[start]
    # p array
    counter-1
  end
end
