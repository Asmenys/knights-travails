# frozen_string_literal: true

class Board
  include Display

  attr_accessor :main_board

  def initialize
    @main_board = Array.new(8) { Array.new(8) { Node.new } }
    connect_board_nodes_vertically
    connect_nodes_horizontally
    index_the_nodes
  end

  def connect_board_nodes_vertically(index = 1)
    current_row = @main_board[index]
    above_row = @main_board[index - 1]
    if current_row.nil?
      nil
    else
      current_row.each_with_index do |node, temp_index|
        upper_node = above_row[temp_index]
        node.up = upper_node
        upper_node.down = node
      end
      connect_board_nodes_vertically(index += 1)
    end
  end

  def connect_nodes_horizontally
    @main_board.each do |row|
      row.each_with_index do |node, index|
        right_node = row[index + 1]
        node.right = right_node
        right_node.left = node if right_node.nil? == false
      end
    end
  end

  def index_the_nodes(row_index = 8)
    @main_board.each do |row|
      letter_ord = 65
      row.each do |node|
        node.index = "#{letter_ord.chr}#{row_index}"
        letter_ord += 1
      end
      row_index -= 1
    end
  end

  def get_node_from_index(node_index)
    node_column = 65 - node_index[0].ord
    node_row = 8 - node_index[1].to_i
    @main_board[node_row][node_column]
  end
end

class Node
  attr_accessor :piece, :left, :right, :up, :down, :index

  def initialize
    @index = nil
    @piece = ' '
    @left = nil
    @right = nil
    @up = nil
    @down = nil
  end
end