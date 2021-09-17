require_relative 'node'
require_relative 'merge_sort'
require 'pry-byebug'

class Tree
  attr_accessor :root

  def initialize(list)
    @root = build_tree(list)
  end

  def build_tree(list)
    return nil if list.empty?

    list = list.sort.uniq
    mid = (list.size - 1)/2.floor
    new_node = Node.new(list[mid])
    new_node.left_child = build_tree(list[0...mid])
    new_node.right_child = build_tree(list[(mid + 1)..-1])
    new_node
  end

  # insert node of given value in tree
  def insert(value, node = root)
    return node = Node.new(value) if node.nil?

    return node if node.data == value

    # Value will go on the right subtree
    if node.data < value
      node.right_child = insert(value, node.right_child)
    # Value will go on the left subtree
    else
      node.left_child = insert(value, node.left_child)
    end
    node
  end

  # delete node of given value in tree
  def delete(value, node = root)
    return node if node.nil?

    # Value to delete is on the left subtree
    if value < node.data
      node.left_child = delete(value, node.left_child)
    # Value to delete is on the right subtree
    elsif value > node.data
      node.right_child = delete(value, node.right_child)
    # node has 1 or no children
    elsif node.left_child.nil?
      return node.right_child
    elsif node.right_child.nil?
      return node.left_child
    # node has 2 children
    else
      temp = succesor(node.right_child)
      node.data = temp.data
      node.right_child = delete(temp.data, node.right_child)
    end
    node
  end

  # Find the next highest value on the right subtree of a node
  def succesor(node)
    node = node.left_child until node.left_child.nil?
    node
  end

  # Find and return node of value in tree
  def find(value, node = root)
    # Value is not in tree
    return nil if node.nil?

    # Value to find is on the left subtree
    if value < node.data
      node = find(value, node.left_child)
    # Value to find is on the right subtree
    elsif value > node.data
      node = find(value, node.right_child)
    end
    node
  end

  def level_order(node = root)
    queue = [node]
    result = []
    until queue.empty?
      result.push(node.data)
      queue.shift
      queue.push(node.left_child) unless node.left_child.nil?
      queue.push(node.right_child) unless node.right_child.nil?
      node = queue[0]
    end
    result
  end

  def inorder(node = root)
    return if node.nil?

    inorder(node.left_child)
    print " #{node.data}"
    inorder(node.right_child)
  end

  def preorder(node = root)
    return if node.nil?

    print " #{node.data}"
    preorder(node.left_child)
    preorder(node.right_child)
  end

  def postorder(node = root)
    return if node.nil?

    postorder(node.left_child)
    postorder(node.right_child)
    print " #{node.data}"
  end

  def height(node = root)    
    return -1 if node.nil?

    [height(node.left_child), height(node.right_child)].max + 1
  end

  def depth(node)
    height(root) - height(node)
  end

  def balanced?(node = root)
    return true if node.nil?

    return true if (height(node.left_child) - height(node.right_child)).abs <= 1 &&
                   balanced?(node.left_child) &&
                   balanced?(node.right_child)

    false
  end

  def rebalance
    self.root = build_tree(level_order)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right_child, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_child
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left_child, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_child
  end
end
