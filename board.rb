# frozen_string_literal: true

class Board
  include Display

  attr_accessor :main_board

  def initialize
    @main_board = Array.new(8) { Array.new(8) { Node.new } }
  end

  def get_node_from_index(node_index)
    main_board[node_index[0]][node_index[1]]
  end

  def remove_piece(node_index)
    get_node_from_index(node_index).piece = ' '
  end

  def add_piece(piece_index, node_index)
    node = get_node_from_index(node_index)
    reference_hash = { 'K' => -> { node.piece = Knight.new(node_index) } }
    reference_hash[piece_index].call
  end

  def move_piece(node_index, destination_index)
    current_node = get_node_from_index(node_index)
    destination_node = get_node_from_index(destination_index)
    piece = current_node.piece
    remove_piece(node_index)
    destination_node.piece = piece
  end
end

class Node
  attr_accessor :piece

  def initialize
    @piece = ' '
  end
end
