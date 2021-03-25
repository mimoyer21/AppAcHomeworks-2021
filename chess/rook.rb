require_relative "slideable"
require_relative "piece"

class Rook < Piece
    include Slideable

    def symbol
        :R
    end

    private
    def move_dirs
        [:horizontal]
    end
end