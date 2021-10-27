# frozen_string_literal: true

require_relative 'display'
require_relative 'game_pieces'
require_relative 'board'

require 'pry-byebug'
board = Board.new
board.main_board[0][0].piece = Knight.new
binding.pry
bind
