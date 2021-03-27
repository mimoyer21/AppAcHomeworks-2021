require "colorize"
require "byebug"

class Piece
    attr_reader :color, :board, :pos

    def initialize(color, board, pos)
        @color = color
        @board = board
        @pos = pos

    end

    def to_s
        if self.is_a?(NullPiece)
            "_"
        elsif @color == :black
            symbol.to_s.blue
        elsif @color == :white
            symbol.to_s.yellow
        end
    end

    def empty?
        self.is_a?(NullPiece)
    end

    def valid_moves
        self.moves.reject { |move| move_into_check?(move) }
    end

    def pos=(val)
        @pos = val
    end

    def symbol

    end

    private
    def move_into_check?(end_pos)
        new_board = board.dup

        new_board.move_piece!(@color, @pos, end_pos)

        new_board.in_check?(@color)
    end
end