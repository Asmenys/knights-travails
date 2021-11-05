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
end

class Graph
  attr_accessor :root

  def initialize(root_index, destination_index)
    @explored_nodes = []
    @destination_index = destination_index
    @root = build_graph(root_index)
  end

  def build_graph_recursive(root_index)
    if root_index[0] > 7 || (root_index[0]).negative? || root_index[1] > 7 || (root_index[1]).negative?
      nil
    elsif root_index == @destination_index
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

  def build_graph(root_index)
    solution_found = false
    root = Node.new(root_index)
    queue = [root]
    while queue.empty? == false
      temp_node = queue.shift
      if solution_found == true || @explored_nodes.include?(temp_node.value) || (temp_node.value[0] || temp_node.value[1]).negative? || temp_node.value[0] > 7 || temp_node.value[1] > 7
        nil
      elsif temp_node.value == @destination_index
        solution_found = true
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

  # def graph_to_path
  #   explored_nodes = [@root]
  #   queue = [@root]
  #   while queue.empty? == false
  #     temp_node = queue.shift
  #   end
  # end

  def graph_to_bft
    explored_nodes = [@root]
    queue = [@root]
    while queue.empty? == false
      temp_node = queue.shift
      if temp_node == @destination_index
        temp_node
      else
        temp_arr = []
        temp_arr << temp_node.up_left
        temp_arr << temp_node.up_right
        temp_arr << temp_node.right_up
        temp_arr << temp_node.right_down
        temp_arr << temp_node.down_right
        temp_arr << temp_node.down_left
        temp_arr << temp_node.left_up
        temp_arr << temp_node.left_down
        temp_arr = temp_arr.compact
        temp_arr.each do |node|
          if explored_nodes.include?(node) == false
            explored_nodes << node
            queue << node
          end
        end
      end
    end
  end
end
graph = Graph.new([4, 4], [5, 6])

binding.pry
bind
