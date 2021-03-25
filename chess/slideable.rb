require "byebug"

module Slideable
    # all position deltas for moving in a horizontal line
    HORIZONTAL_DIRS = [[-1, 0], [1, 0], [0, -1], [0, 1]]
    # all position deltas for moving in a diagonal line
    DIAGONAL_DIRS = [[-1, -1], [-1, 1], [1, -1], [1, 1]]

    def horizontal_dirs
        HORIZONTAL_DIRS
    end

    def diagonal_dirs
        DIAGONAL_DIRS
    end

    def moves
        my_moves = []
        
        my_move_dirs = []
        my_move_dirs += HORIZONTAL_DIRS if move_dirs.include?(:horizontal)
        my_move_dirs += DIAGONAL_DIRS if move_dirs.include?(:diagonal)

        my_move_dirs.each do |dx, dy|
            cur_x, cur_y = pos
            new_x = cur_x + dx
            new_y = cur_y + dy
            new_pos = [new_x, new_y]

            until !@board.valid_pos?(new_pos) || @board[new_pos].color == self.color
            # until !new_pos.all? { |i| i.between?(0,7) } || @board[new_pos].color == self.color
                my_moves << new_pos
                break if !@board[new_pos].color.nil? && @board[new_pos].color != self.color # don't allow further movement if run into piece of opposing color

                new_x = new_x + dx
                new_y = new_y + dy
                new_pos = [new_x, new_y]
            end
        end

        my_moves
    end

    private
    def move_dirs

    end

    def grow_unblocked_moves_in_dir(dx, dy)

    end
end

