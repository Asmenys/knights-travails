# frozen_string_literal: true

require_relative 'path'
require_relative 'display'

class Board
  include Display

  attr_accessor :board

  def initialize
    @board = Array.new(8) { Array.new(8) }
  end

  def add_piece(board_index)
    @board[board_index[0]][board_index[1]] = 'K'
    print_board
  end

  def remove_piece(board_index)
    @board[board_index[0]][board_index[1]] = nil
    print_board
  end

  def knight_moves(piece_location, destination_index)
    temp_path = Path.new(piece_location, destination_index)
    path = temp_path.path
    remove_piece(piece_location)
    add_piece(destination_index)
    if path.length == 1
      p "You made it in 1 move, #{piece_location} to #{destination_index}"
    else
      p "You made it in #{path.length} moves :"
      path.each do |move|
        p move
      end
    end
    print_board
  end
end