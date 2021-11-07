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
    destination_index?(destination_index) == false && adjacent_node_values(self).all?(nil)
  end

  def destination_index?(destination_index)
    value == destination_index
  end

  def get_adjacent_nodes
    [
      up_left,
      up_right,
      left_up,
      left_down,
      down_left,
      down_right,
      right_up,
      right_down
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
    explored_nodes = []
    while queue.empty? == false
      temp_node = queue.shift
      if [explored_nodes.include?(temp_node.value), temp_node.value[0].negative?, temp_node.value[1].negative?,
          temp_node.value[0] > 7, temp_node.value[1] > 7].any?(true)
        nil
      elsif temp_node.value == @destination_index
        Node.new(temp_node)
      else
        p temp_node.value
        explored_nodes << temp_node.value
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
          queue << node
        end
      end
    end
    root
  end

  def build_graph_recursive(root_index)
    if @explored_nodes.include?(root_index) || (root_index[0] || root_index[1]).negative? || root_index[0] > 7 || root_index[1] > 7
      nil
    elsif root_index == @destination_index
      Node.new(root_index)
    else
      @explored_nodes << root_index
      up_left = [root_index[0] - 2, root_index[1] - 1]
      up_right = [root_index[0] - 2, root_index[1] + 1]
      left_up = [root_index[0] - 1, root_index[1] - 2]
      left_down = [root_index[0] + 1, root_index[1] - 2]
      down_left = [root_index[0] + 2, root_index[1] - 1]
      down_right = [root_index[0] + 2, root_index[1] + 1]
      right_up = [root_index[0] - 1, root_index[1] + 2]
      right_down = [root_index[0] + 1, root_index[1] + 2]
      Node.new(root_index,
               build_graph_recursive(up_left),
               build_graph_recursive(up_right),
               build_graph_recursive(right_up),
               build_graph_recursive(right_down),
               build_graph_recursive(down_right),
               build_graph_recursive(down_left),
               build_graph_recursive(left_up),
               build_graph_recursive(left_down))
    end
  end

  # def delete_pointless_leafs(root = @root)
  #  root.up_left = nil if root.up_left.pointless?(@destination_index)
  #  root.up_right = nil if root.up_right.pointless?(@destination_index)
  #  root.left_up = nil if root.left_up.pointless?(@destination_index)
  #  root.left_down = nil if root.left_down.pointless?(@destination_index)
  #  root.down_left = nil if root.down_left.pointless?(@destination_index)
  #  root.down_right = nil if root.down_right.pointless?(@destination_index)
  #  root.right_up = nil if root.right_up.pointless?(@destination_index)
  #  root.right_down = nil if root.right_down.pointless?(@destination_index)
  #  adj_nodes = root.get_adjacent_nodes
  #  adj_nodes.each do |node|
  #    delete_pointless_leafs(node)
  #  end
  # end

  def delete_pointless_leafs(root = @root)
    root.up_left = delete_node(root.up_left)
    root.up_right = delete_node(root.up_right)
    root.left_up = delete_node(root.left_up)
    root.left_down = delete_node(root.left_down)
    root.down_left = delete_node(root.down_left)
    root.down_right = delete_node(root.down_right)
    root.right_up = delete_node(root.right_up)
    root.right_down = delete_node(root.right_down)
    adj_nodes = root.get_adjacent_nodes.compact
    adj_nodes.each do |node|
      delete_pointless_leafs(node)
    end
  end

  def really_delete_all_the_pointless_nodes
    previous_result = delete_pointless_leafs
    last_result = delete_pointless_leafs
    while last_result != previous_result
      previous_result = delete_pointless_leafs
      last_result = delete_pointless_leafs
    end
  end

  def delete_node(node)
    if node.nil? == false
      if node.pointless?(@destination_index)
        nil
      else
        node
      end
    end
  end

  def path
    path = []
    queue = [@root]
    while queue.empty? == false
      temp_node = queue.shift
      path << temp_node.value
      adj_nodes = temp_node.get_adjacent_nodes.compact
      binding.pry
      adj_nodes.each do |node|
        queue << node
      end
    end
    path if path.include?(@destination_index)
  end
end
graph = Graph.new([4, 4], [2, 0])
binding.pry
graph.delete_pointless_leafs
graph.path
bind
