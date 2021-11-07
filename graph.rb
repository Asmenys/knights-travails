# frozen_string_literal: true

require 'pry-byebug'
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

  def pointless?(destination_index)
    self.destination_index?(destination_index) == false && adjacent_node_values(self).all?(nil)
  end

  def destination_index?(destination_index)
    self.value == destination_index
  end

  def get_adjacent_nodes
    [
      self.up_left,
      self.up_right,
      self.left_up,
      self.left_down,
      self.down_left,
      self.down_right,
      self.right_up,
      self.right_down
    ]
  end

  def adjacent_node_values(node)
    values = []
    adjacent_nodes = node.get_adjacent_nodes
    adjacent_nodes.each do |node|
      values << if node.nil?
                  nil
                else
                  node.value
                end
    end
  end
end

class Graph
  attr_accessor :root, :array

  def initialize(root_index, destination_index)
    @explored_nodes = []
    @destination_index = destination_index
    @root = build_graph(root_index)
  end

  def build_graph(root_index)
    root = Node.new(root_index)
    queue = [root]
    while queue.empty? == false
      temp_node = queue.shift
      if @explored_nodes.include?(temp_node.value) || (temp_node.value[0] || temp_node.value[1]).negative? || temp_node.value[0] > 7 || temp_node.value[1] > 7
        nil
      elsif temp_node.value == @destination_index
        Node.new(temp_node)
      else
        temp_arr = [
          temp_node.up_left =   Node.new([temp_node.value[0] - 2, temp_node.value[1] - 1]),
          temp_node.up_right =  Node.new([temp_node.value[0] - 2, temp_node.value[1] + 1]),
          temp_node.left_up =   Node.new([temp_node.value[0] - 1, temp_node.value[1] - 2]),
          temp_node.left_down = Node.new([temp_node.value[0] + 1, temp_node.value[1] - 2]),
          temp_node.down_left = Node.new([temp_node.value[0] + 2, temp_node.value[1] - 1]),
          temp_node.down_right = Node.new([temp_node.value[0] + 2, temp_node.value[1] + 1]),
          temp_node.right_up = Node.new([temp_node.value[0] - 1, temp_node.value[1] + 2]),
          temp_node.right_down = Node.new([temp_node.value[0] + 1, temp_node.value[1] + 2])
        ]
        temp_arr.each do |node|
          @explored_nodes << node.value
          queue << node
        end
      end
    end
    root
  end

  def delete_pointless_leafs(root = @root)
    root.up_left = nil if root.up_left.pointless?(@destination_index)
    root.up_right = nil if root.up_right.pointless?(@destination_index)
    root.left_up = nil if root.left_up.pointless?(@destination_index)
    root.left_down = nil if root.left_down.pointless?(@destination_index)
    root.down_left = nil if root.down_left.pointless?(@destination_index)
    root.down_right = nil if root.down_right.pointless?(@destination_index)
    root.right_up = nil if root.right_up.pointless?(@destination_index)
    root.right_down = nil if root.right_down.pointless?(@destination_index)
  end

  def path
    delete_pointless_leafs
    path = []
    queue = [@root]
    while queue.empty? == false
      temp_node = queue.shift
      path << temp_node.value
      adj_nodes = temp_node.get_adjacent_nodes.compact
      adj_nodes.each do |node|
        queue << node
      end
    end
  if path.include?(@destination_index)
    path
  else
    nil
  end
end
end

graph = Graph.new([4, 4], [5, 6])
graph.delete_pointless_leafs
binding.pry
graph.path
bind
