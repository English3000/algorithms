# https://leetcode.com/problems/merge-k-sorted-lists/description/
# Merge k sorted linked lists and return it as one sorted list. Analyze and describe its complexity.

# Definition for singly-linked list.
# class ListNode
#     attr_accessor :val, :next
#     def initialize(val)
#         @val = val
#         @next = nil
#     end
# end

# param {ListNode[]} lists
# return {ListNode}
def merge_k_lists(lists) #Time: O(length of lists * total # of nodes) #Space: O(1) for highest, O(...) for list, <O(...) for current_node--so Space == Time
    #compare val's of all Linked Lists & create new one
        #here, takes time equal to the number of nodes, w/ comparison make on insertion
    list = nil
    current_node = nil

    lowest = []
        #but how to move along ListNodes? need a current_node for each list
    # current_nodes = lists.dup
    lists.each do |list|
        lists.delete(list) if list.nil?
    end

    until lists.empty? #O(1), how many times = total # of nodes
        lists.each_with_index do |list, idx| #O(lists.length)
           lowest = [list.val, idx] if lowest.empty? || list.val < lowest[0]
        end

        if current_node.nil?
            list = ListNode.new(lowest.first)
            current_node = list
        else
            current_node.next = ListNode.new(lowest.first)
            current_node = current_node.next
        end

        if lists[lowest.last].next.nil?
            lists.delete_at(lowest.last)
        else
            lists[lowest.last] = lists[lowest.last].next
        end
        lowest = []
    end

    list
end
#make arrays of all lists' values, sort, & create Linked List
        #takes time equal to number of nodes (for array creation & list creation) plus time to sort arrays in order
# same Time, more Space
