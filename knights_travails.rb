# frozen_string_literal: true

require_relative 'display'
require 'pry-byebug'

class Board
  include Display

  attr_accessor :board

  def initialize
    @board = Array.new(8) { Array.new(8) }
  end

  def add_piece(board_index)
    @board[board_index[0]][board_index[1]] = 'K'
  end

  def remove_piece(board_index)
    @board[board_index[0]][board_index[1]] = nil
  end

  def knight_moves(piece_location, destination_index)
    binding.pry
  end
end

board = Board.new
binding.pry
board.add_piece([4, 4])
board.knight_moves([4, 4], [6, 5])
bind
