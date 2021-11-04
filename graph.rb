# frozen_string_literal: true

class Node
  attr_accessor :value, :up_left, :up_right, :right_down, :right_up, :left_down, :left_up, :down_left, :down_right

  def initialize(value = nil, up_left = nil, up_right = nil, right_up = nil, right_down = nil, down_right = nil, down_left = nil, left_up = nil, left_down = nil)
    @value = value
    @up_left = up_left
    @up_right = up_right
    @right_down = right_down
    @right_up = right_up
    @down_right = down_right
    @down_left = down_left
    @left_up = left_up
    @left_down = left_down
  end
end

class Graph
  attr_accessor :root

  def initialize(root_index, destination_index)
    @explored_nodes = []
    @destination_index = destination_index
    @root = build_graph(root_index)
  end

  def build_graph(root_index)
    if @explored_nodes.include?(root_index) || root_index[0] > 8 || (root_index[0]).negative? || root_index[1] > 8 || (root_index[1]).negative?
      nil
    elsif root_index == @destination_index
      @explored_nodes << @destination_index
      Node.new(root_index)
    else
      @explored_nodes << root_index
      value = root_index
      up_left = [root_index[0] - 2, root_index[1] - 1]
      up_right = [root_index[0] - 2, root_index[1] + 1]
      left_up = [root_index[0] - 1, root_index[1] - 2]
      left_down = [root_index[0] + 1, root_index[1] - 2]
      down_left = [root_index[0] + 2, root_index[1] - 1]
      down_right = [root_index[0] + 2, root_index[1] + 1]
      right_up = [root_index[0] - 1, root_index[1] + 2]
      right_down = [root_index[0] + 1, root_index[1] + 2]
      Node.new(value,
               build_graph(up_left),
               build_graph(up_right),
               build_graph(right_up),
               build_graph(right_down),
               build_graph(down_right),
               build_graph(down_left),
               build_graph(left_up),
               build_graph(left_down))
    end
  end
end
