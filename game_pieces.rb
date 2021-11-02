# frozen_string_literal: true

class Knight
  attr_reader :piece_index

  def initialize(board_index)
    @piece_index = 'K'
    @current_location = board_index
  end

  def knight_moves(knight_location, destination_index)
    binding.pry
  end
end
