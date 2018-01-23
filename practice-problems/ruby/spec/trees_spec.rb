require 'rspec'
require 'trees'

describe "#preorder" do
  it "prints a string with the values of a tree, in order, separated by spaces" do
    root = Node.new(1, Node.new(2, Node.new(5, Node.new(3, Node.new(4)), Node.new(6))))
    expect(preorder(root)).to eq("1 2 5 3 4 6")
  end
end
