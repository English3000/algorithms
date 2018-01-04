require_relative 'heap' #why is this here? CAN ASK TOM.
# require_relative 'heap_sort'

def k_largest_elements(array, k)
  array.sort[(array.length - k)...array.length] #works
  # array.heap_sort![(array.length - k)...array.length] #sometimes works
end
