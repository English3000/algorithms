# Given an Array of tuples, where tuple[0] represents a package id,
# and tuple[1] represents its dependency, determine the order in which
# the packages should be installed. Only packages that have dependencies
# will be listed, but all packages from 1..max_id exist.

# N.B. this is how `npm` & `webpack` work.
# can use for scheduling

# Import any files you need to
require_relative 'graph'

def install_order(arr)
  graph = {}
  order = []
  max = nil
  min = nil
  # could make each package id a Vertex & each dependency an out-edge
  arr.each do |tuple|
    package_id = tuple[0]
    dependency = tuple[1]

    if package_id > dependency
      max = package_id if !max || package_id > max
      min = dependency if !min || dependency < min
    else
      max = dependency if !max || dependency > max
      min = package_id if !min || package_id < min
    end

    graph[package_id] = Vertex.new(package_id) unless graph[package_id]
    graph[dependency] = Vertex.new(dependency) unless graph[dependency]
    Edge.new(graph[dependency], graph[package_id])

    order.push(dependency) unless order.include?(dependency)
  end

  # .each should iterate thru new entries
  order.each do |package_id|
    graph[package_id].out_edges.each do |edge|
      value = edge.to_vertex.value
      order.push(value) unless order.include?(value)
    end
  end

  (min..max).each {|id| order.unshift(id) unless order.include?(id)}

  order
end
