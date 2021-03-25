class Piece
    attr_reader :color, :board, :pos

    def initialize(color, board, pos)
        @color = color
        @board = board
        @pos = pos

    end

    def to_s
        
    end

    def empty?
        # self.is_a?(NullPiece)
    end

    def valid_moves
        self.moves
    end

    def pos=(val)
        @pos = val
    end

    def symbol

    end

    private
    def move_into_check?(end_pos)

    end
end