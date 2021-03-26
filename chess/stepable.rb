require "byebug"

module Stepable
    def moves
        cur_x, cur_y = pos
        my_moves = move_diffs.map { |dx, dy| [cur_x + dx, cur_y + dy] }

        # remove moves to a position not on the board or to a position with same color piece already in it
        my_moves.select! do |end_pos| 
            @board.valid_pos?(end_pos) && @board[end_pos].color != self.color
        end

        my_moves        
    end

    def move_diffs

    end
end