# frozen_string_literal: true

require_relative 'display'
require_relative 'game_pieces'
require_relative 'board'

require 'pry-byebug'
board = Board.new
board.add_piece('K', [4,4])
binding.pry

bind
