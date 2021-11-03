# frozen_string_literal: true

module Display
  def print_board
    board_array = board_to_array
    temp_node_index = 0
    temp_row_index = 0
    p '    0    1    2    3    4    5    6    7'
    p '-------------------------------------------'
    while temp_node_index < 8
      p "#{temp_node_index} |#{board_array[temp_row_index].join}"
      p '-------------------------------------------'
      temp_node_index += 1
      temp_row_index += 1
    end
  end

  def board_to_array
    board_array = Array.new(8) { Array.new(8) }
    temp_row_index = 0
    @board.each do |row|
      row.each_with_index do |node, index|
        board_array[temp_row_index][index] = if node.nil?
                                               '    |'
                                             else
                                               " #{node}  |"
                                             end
      end
      temp_row_index += 1
    end
    board_array
  end
end
