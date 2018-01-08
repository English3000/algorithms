class BSTNode
  attr_reader :value
  attr_accessor :parent, :left, :right

  def initialize(value, parent = nil)
    @value = value
    @parent = parent
    @left = nil
    @right = nil
  end
end
