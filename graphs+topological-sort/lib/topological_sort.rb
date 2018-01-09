require_relative 'graph'

# Implementing topological sort using both Kahn's and Tarian's algorithms

# video doesn't mention Tarian's algorithm

def topological_sort(vertices) # array => # layers of unordered sets (could implement these as subarrays)
  # Kahn's alg. #Coffman-Graham gives deterministic sorting
  #look for vertices w/o @in_edges; add to list
  #look for vertices w/o @in_edges (exclude @in_edges in list)
  #repeat until all vertices in the list

  #w/o queue
  list = []

  until list.length == vertices.length
    changed = false
    vertices.each do |vertex|
      if !list.include?(vertex) && ( vertex.in_edges.length == 0 ||
        vertex.in_edges.all?{|edge| list.include?(edge.from_vertex)} )
        list.push(vertex)
        changed = true
      end
    end

    return [] if !changed
  end

  list

  # #w/ queue (could also implement by enqueueing out-edges' to-vertices
    # for each node added to list, replacing queue.each w/ until queue.empty?)
  # list = []
  # queue = []
  #
  # full = vertices.length
  #
  # until list.length == full
  #   changed = false
  #   vertices.each do |vertex|
  #     if vertex.in_edges.length == 0 && !list.include?(vertex)
  #       queue.push(vertex)
  #     end
  #   end
  #
  #   queue.each do |vertex|
  #     vertex.out_edges.each {|edge| edge.destroy!} #causes spec's test to malfunction
  #     list.push(queue.shift)
  #     changed = true
  #   end
  #
  #   return [] if !changed
  # end
end
