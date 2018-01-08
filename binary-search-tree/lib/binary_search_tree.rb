# There are many ways to implement these methods, feel free to add arguments
# to methods as you see fit, or to create helper methods.
require 'bst_node'

class BinarySearchTree
  attr_accessor :root

  def initialize
    @root = nil
  end

  def insert(value)
    if !@root
      @root = BSTNode.new(value, nil)
    else
      current_node = @root

      while true
        if value <= current_node.value

          if !current_node.left
            current_node.left = BSTNode.new(value, current_node)
            break
          else
            current_node = current_node.left
          end
        else

          if !current_node.right
            current_node.right = BSTNode.new(value, current_node)
            break
          else
            current_node = current_node.right
          end
        end

      end

    end
  end

  def find(value, tree_node = @root)
    while true
      if tree_node == nil
        return nil

      elsif value == tree_node.value
        return tree_node

      elsif value < tree_node.value
        return nil if tree_node.left == nil

        value == tree_node.left.value ?
          (return tree_node.left) : tree_node = tree_node.left
      else
        return nil if tree_node.right == nil

        value == tree_node.right.value ?
          (return tree_node.right) : tree_node = tree_node.right
      end
    end
  end

  def delete(value)
    node = find(value)

    if node == nil
      return nil
    elsif node.left && node.right
      subroot = maximum(node.left)

      unless subroot == node.left
        subroot.parent.right = subroot.left
        subroot.left.parent = subroot.parent if subroot.left
      end

      if node.parent
        node.parent.left = subroot
        subroot.parent = node.parent
      end

      subroot.left = node.left
      subroot.right = node.right
      node = subroot

    elsif node.left
      node.left.parent = node.parent
      if node.left.value <= node.parent.value
        node.parent.left = node.left
      else
        node.parent.right = node.left
      end
    elsif node.right
      node.right.parent = node.parent
      if node.right.value <= node.parent.value
        node.parent.left = node.right
      else
        node.parent.right = node.right
      end
    elsif node == @root
      @root = nil
    else
      if node.value <= node.parent.value
        node.parent.left = nil
      else
        node.parent.right = nil
      end
    end
  end

  # helper method for #delete:
  def maximum(tree_node = @root)
    while true
      return tree_node if !tree_node || tree_node.right == nil
      tree_node = tree_node.right
    end
  end

  def depth(tree_node = @root)
    return 0 if !tree_node || !tree_node.left && !tree_node.right

    left_depth = 0
    right_depth = 0

    left_depth = depth(tree_node.left) + 1 if tree_node.left
    right_depth = depth(tree_node.right) + 1 if tree_node.right

    left_depth > right_depth ? left_depth : right_depth
  end

  def is_balanced?(tree_node = @root)
    return true if !tree_node
    unless (depth(tree_node.left) - depth(tree_node.right)).abs < 2 &&
      is_balanced?(tree_node.left) && is_balanced?(tree_node.right)
      false
    else
      true
    end
  end

  def in_order_traversal(tree_node = @root, arr = [])
    #visits left children, then self, then right children
    return arr if !tree_node

    if tree_node.left
      tree_node.left.left ?
        in_order_traversal(tree_node.left, arr) : arr.push(tree_node.left.value)
    end

    arr.push(tree_node.value)
    in_order_traversal(tree_node.right, arr) if tree_node.right

    arr
  end


  private
  # optional helper methods go here:

end
