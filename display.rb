# frozen_string_literal: true

module Display
  def print_board
    board_array = board_to_array
    temp_node_index = 8
    temp_row_index = 0
    p '    A    B    C    D    E    F    G    H'
    p '-------------------------------------------'
    while temp_node_index.positive?
      p "#{temp_node_index} |#{board_array[temp_row_index].join}"
      p '-------------------------------------------'
      temp_node_index -= 1
      temp_row_index += 1
    end
  end

  def board_to_array
    board_array = Array.new(8) { Array.new(8) }
    temp_row_index = 0
    @main_board.each do |row|
      row.each_with_index do |node, index|
        board_array[temp_row_index][index] = if node.piece == ' '
                                               "#{node.piece}   |"
                                             else
                                               "#{node.piece.piece_index}   |"
                                             end
      end
      temp_row_index += 1
    end
    board_array
  end
end
