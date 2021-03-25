require_relative "slideable"
require_relative "piece"

class Queen < Piece
    include Slideable

    def symbol
        :Q
    end

    private
    def move_dirs
        [:horizontal, :diagonal]
    end
end