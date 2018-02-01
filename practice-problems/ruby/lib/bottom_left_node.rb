# https://leetcode.com/problems/find-bottom-left-tree-value/description/
# Given a binary tree, find the leftmost value in the last row of the tree.

# Definition for a binary tree node.
# class TreeNode
#     attr_accessor :val, :left, :right
#     def initialize(val)
#         @val = val
#         @left, @right = nil, nil
#     end
# end

# param {TreeNode} root
# return {Integer}
def find_bottom_left_value(root)
    #find left most value in bottom row
    #start at root, traverse left to bottom & record depth,
    # check for any right nodes, traverse left & record depth
    nodes = [[root, 0]] #node, depth
    #I'd add second input for depth
    nodes.concat(find_deepest_node(root.left, 1)) if root.left
    nodes.concat(find_deepest_node(root.right, 1)) if root.right

    deepest_node = nodes[0]
    (1...nodes.length).each do |i|
       deepest_node = nodes[i] if nodes[i][1] > deepest_node[1]
    end

    deepest_node[0].val
end

def find_deepest_node(node, depth)
    return [[node, depth]] if !node.left && !node.right

    return_values = []

    #so can concat return_values w/o extra nesting
    return_values.concat(find_deepest_node(node.left, depth+1)) if node.left
    return_values.concat(find_deepest_node(node.right, depth+1)) if node.right

    return_values
end
