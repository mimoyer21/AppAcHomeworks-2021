require_relative "piece"

class Pawn < Piece

    def symbol
        :P
    end

    def moves
        forward_steps + side_attacks
    end

    private
    def at_start_row?
        row = pos[0]
        
        return true if color == :black && row == 1
        return true if color == :white && row == 6

        false
    end
    
    def forward_dir
        if color == :black
            return 1
        else
            return -1
        end
    end

    def forward_steps
        available_fwd_steps = []
        row, col = pos

        one_step = [row + forward_dir, col]
        return [] if !@board.valid_pos?(one_step) # at end of board and can't go forward

        # check if position one step forward is empty
        if @board[one_step].is_a?(NullPiece)
            available_fwd_steps << one_step
        else
            return []
        end

        if at_start_row?
            two_steps = [row + (2 * forward_dir), col]

            available_fwd_steps << two_steps if @board.valid_pos?(two_steps) && @board[two_steps].is_a?(NullPiece)
        end

        available_fwd_steps
    end

    def side_attacks
        available_attacks = []

        row, col = pos
        side_attack_positions = [[row + forward_dir, col + 1], [row + forward_dir, col - 1]]

        side_attack_positions.each do |position|
            next if !@board.valid_pos?(position)
            is_opposing_piece = !@board[position].color.nil? && @board[position].color != self.color
            
            available_attacks << position if is_opposing_piece
        end

        available_attacks
    end
end