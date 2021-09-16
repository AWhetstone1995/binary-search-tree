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

  def insert(value, node = root)
    # binding.pry
    return node = Node.new(value) if node.nil?

    return node if node.data == value

    if node.data < value
      node.right_child = insert(value, node.right_child)
    else
      node.left_child = insert(value, node.left_child)
    end
    node
  end

  def delete(value, node = root)
    # binding.pry
    return node if node.nil?

    if value < node.data
      node.left_child = delete(value, node.left_child)
    elsif value > node.data
      node.right_child = delete(value, node.right_child)
    # node has 1 or no children
    elsif node.left_child.nil?
      return node.right_child
    elsif node.right_child.nil?
      return node.left_child
    # node has 2 children
    else
      # something
    end
    node
  end

  def find(value, node = root)
    # binding.pry
    return nil if node.nil?

    if value < node.data
      node = find(value, node.left_child)
    elsif value > node.data
      node = find(value, node.right_child)
    end
    node
  end

  def inorder(node)
    # binding.pry
    return if node.nil?

    inorder(node.left_child)
    print " #{node.data}"
    inorder(node.right_child)
  end

  def preorder(node)
    return if node.nil?

    print " #{node.data}"
    preorder(node.left_child)
    preorder(node.right_child)
  end

  def postorder(node)
    return if node.nil?

    postorder(node.left_child)
    postorder(node.right_child)
    print " #{node.data}"
  end

  def height(value, node = root)
    return nil if node.nil?

    if value < node.data
      1 + height(value, node.left_child)
    elsif value > node.data
      1 + height(value, node.right_child)
    end
    0
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
# tree.pretty_print

tree.insert(10)
tree.pretty_print
puts "\n \n \n"
tree.delete(9)
tree.pretty_print
# p tree.find(4)
# p tree.find(6345)

# tree.inorder(tree.root)
# puts "\n \n \n"
# tree.preorder(tree.root)
# puts "\n \n \n"
# tree.postorder(tree.root)
# puts "\n \n \n"

# p tree.height(27)