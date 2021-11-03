# frozen_string_literal: true

require 'pry-byebug'

class Graph_Node
  def initialize(up_left = nil, up_right = nil, right_up = nil, right_down = nil, down_right = nil, down_left = nil, left_up = nil, left_down = nil)
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
  def initialize(root_index, destination_index)
    @root = build_graph(root_index, destination_index)
  end

  def build_graph(root_index, destination_index)
    if root_index[0] > 8 || (root_index[0]).negative? || root_index[1] > 8 || (root_index[1]).negative?
      nil
    elsif root_index == destination_index
      destination_index
    else
      up_right = [root_index[0] - 2, root_index[1] - 1]
      up_left = [root_index[0] - 2, root_index[1] + 1]
      right_up = [root_index[0] - 1, root_index[1] - 2]
      right_down = [root_index[0] + 1, root_index[1] - 2]
      down_left = [root_index[0] + 2, root_index[1] + 1]
      down_right = [root_index[0] + 2, root_index[1] - 1]
      left_up = [root_index[0] - 1, root_index[1] + 2]
      left_down = [root_index[0] + 1, root_index[1] + 2]
      node = Graph_Node.new(build_graph(up_left, destination_index),
                            build_graph(up_right, destination_index),
                            build_graph(right_up, destination_index),
                            build_graph(right_down, destination_index),
                            build_graph(down_right, destination_index),
                            build_graph(down_left, destination_index),
                            build_graph(left_up, destination_index),
                            build_graph(left_down, destination_index))
    end
  end
end

binding.pry

bind
