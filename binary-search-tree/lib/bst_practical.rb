require 'binary_search_tree'

def kth_largest(tree_node, k) #input is a Node, not a BST
  return nil if k == 0

  tree = BinarySearchTree.new
  tree.root = tree_node
  tree.find(tree.in_order_traversal[-k])
end
