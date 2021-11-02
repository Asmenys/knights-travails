# frozen_string_literal: true

class Board
  include Display

  attr_accessor :main_board

  def initialize
    @main_board = Array.new(8) { Array.new(8) { Node.new } }
  end

  def get_node_from_index(node_index)
    node_column = node_index[0].ord - 65
    node_row = 8 - node_index[1].to_i
    main_board[node_row][node_column]
  end

  def remove_piece(node_index)
    get_node_from_index(node_index).piece = ' '
  end

  def add_piece(piece_index, node_index)
    node = get_node_from_index(node_index)
    reference_hash = {'K' => lambda {node.piece = Knight.new(node_index)}}
    reference_hash[piece_index].call
  end
  def move_piece(node_index, destination_index)
    current_node = get_node_from_index(node_index)
    destination_node = get_node_from_index(destination_node)
    piece_type = current_node.piece
  end
end

class Node
  attr_accessor :piece

  def initialize
    @piece = ' '
  end
end