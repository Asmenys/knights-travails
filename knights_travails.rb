# frozen_string_literal: true

require 'pry-byebug'

class Board
  attr_accessor :main_board

  def initialize
    @main_board = Array.new(8) { Array.new(8) { Node.new } }
    connect_board_nodes_vertically
    connect_nodes_horizontally
  end

  def connect_board_nodes_vertically(index = 1)
    current_row = @main_board[index]
    above_row = @main_board[index - 1]
    if current_row.nil?
      return
    else
      current_row.each do |node|
        above_row.each do |upper_node|
          node.up = upper_node
          upper_node.down = node
        end
      end
    end

    connect_board_nodes_vertically(index += 1)
  end

  def connect_nodes_horizontally
    @main_board.each do |row|
      row.each_with_index do |node, index|
        right_node = row[index]
        node.right = right_node
        right_node.left = node
      end
    end
  end
end

class Node
  attr_accessor :piece, :left, :right, :up, :down

  def initialize
    @piece = nil
    @left = nil
    @right = nil
    @up = nil
    @down = nil
  end
end
binding.pry
kurva zajibal
