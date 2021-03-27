require_relative "stepable"
require_relative "piece"

class King < Piece
    include Stepable

    def symbol
        "\u2654"
    end

    protected
    def move_diffs
        [[-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]]
    end
end