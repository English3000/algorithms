class Vertex
  attr_accessor :value, :in_edges, :out_edges
  def initialize(value)
    @value = value
    #connect vertices
    @in_edges = []
    @out_edges = []
  end
end

# vertex  O ---edge--- O  vertex
# e.g. user ---friendship--- user
  # draw edge only if users are friends

# sparse graph has low density (actual edges/possible edges)
  # |V| (size of set; # of vertices) # |E| (# of edges)
  # density = |E| / |V| * |V-1| # max: 1 (2 w/ 'directed graph'), min: 0

# an algorithm may be slower for a dense graph

# tree: |V| = n, |E| = n - 1 (no cyclical connections)
  # --e.g. the DOM (no explicit directions); density = 1/n

# 4-color theorem

class Edge
  attr_accessor :from_vertex, :to_vertex, :cost
  def initialize(from_vertex, to_vertex, cost = 1)
    #indicate direction of connection
    @from_vertex = from_vertex
    @to_vertex = to_vertex
    @cost = cost

    @to_vertex.in_edges.push(self)
    @from_vertex.out_edges.push(self)
  end

  def destroy!
    @to_vertex.in_edges.delete(self)
    @from_vertex.out_edges.delete(self)

    @to_vertex = nil
    @from_vertex = nil
  end
end
