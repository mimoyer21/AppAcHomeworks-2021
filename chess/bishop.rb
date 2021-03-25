require_relative "slideable"
require_relative "piece"

class Bishop < Piece
    include Slideable

    def symbol
        :B
    end

    private
    def move_dirs
        [:diagonal]
    end
end