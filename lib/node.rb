
class Node
  attr_accessor :data, :left_child, :right_child

  def initialize(data = nil)
    @data = data
    @left_child = nil
    @right_child = nil
  end
  
  def set_left(node)
    self.left_child = node
  end

  def set_right(node)
    self.right_child = node
  end
end
