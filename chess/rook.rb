require_relative "slideable"
require_relative "piece"

class Rook < Piece
    include Slideable

    def symbol
        "\u2656"
    end

    private
    def move_dirs
        [:horizontal]
    end
end