# frozen_string_literal: true

class Node
  attr_accessor :previous_node, :value

  def initialize(current_value = nil, previous_node = nil)
    @previous_node = previous_node
    @value = current_value
  end
end

class Path
  attr_accessor :root, :path

  def initialize(root_index, destination_index)
    @path = []
    @start_index = root_index
    @explored_nodes = []
    @destination_found = false
    @destination_index = destination_index
    @root = Node.new(root_index)
    bfs
  end

  def bfs
    queue = [@root]
    explored_nodes = []
    solution_found = false
    while queue.empty? == false
      previous_node = queue.shift
      array = [
        [previous_node.value[0] - 2, previous_node.value[1] - 1],
        [previous_node.value[0] - 2, previous_node.value[1] + 1],
        [previous_node.value[0] - 1, previous_node.value[1] - 2],
        [previous_node.value[0] + 1, previous_node.value[1] - 2],
        [previous_node.value[0] + 2, previous_node.value[1] - 1],
        [previous_node.value[0] + 2, previous_node.value[1] + 1],
        [previous_node.value[0] - 1, previous_node.value[1] + 2],
        [previous_node.value[0] + 1, previous_node.value[1] + 2]
      ]
      array.each do |current_value|
        if solution_found || invalid_node?(current_value) || explored_nodes.include?(current_value)
          nil
        elsif current_value == @destination_index
          solution_found = true
          backtrack(Node.new(current_value, previous_node))
        else
          queue << Node.new(current_value, previous_node)
        end
      end
    end
  end

  def backtrack(node)
    if node.value == @start_index
    else
      backtrack(node.previous_node)
    end
    @path << node.value
  end

  def invalid_node?(node)
    [node[0] > 7, node[0].negative?, node[1] > 7, node[1].negative?].any?(true)
  end
end
