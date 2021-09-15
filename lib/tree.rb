require_relative 'node'
require_relative 'merge_sort'
require 'pry-byebug'

class Tree
#   include MergeSort
  attr_accessor :root

  def initialize(list)
    list = list.sort.uniq
    @root = build_tree(list)
  end

  def build_tree(list)
    return nil if list.empty?

    mid = (list.size - 1)/2.floor
    new_node = Node.new(list[mid])
    new_node.left_child = build_tree(list[0...mid])
    new_node.right_child = build_tree(list[(mid + 1)..-1])
    new_node
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right_child, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_child
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left_child, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_child
  end
end

list = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
tree = Tree.new(list)
tree.root
tree.pretty_print
