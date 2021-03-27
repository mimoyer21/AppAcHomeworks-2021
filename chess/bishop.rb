require_relative "slideable"
require_relative "piece"

class Bishop < Piece
    include Slideable

    def symbol
        "\u2657"
    end

    private
    def move_dirs
        [:diagonal]
    end
end