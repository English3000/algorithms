# https://www.hackerrank.com/challenges/tree-preorder-traversal/problem

# Print the tree's preorder traversal as a single line of space-separated values.

# INPUT: 1 - 2 - 5 - 3 - 4
                 # - 6

# OUTPUT: 1 2 5 3 4 6

class Node
  attr_reader :value, :left, :right

  def initialize(value, left = nil, right = nil)
    @value = value
    @left = left
    @right = right
  end
end

def preorder(root)
  values = root.value.to_s

  if root.left
    values += ' ' + preorder(root.left)
  end

  if root.right
    values += ' ' + preorder(root.right)
  end

  values
end
