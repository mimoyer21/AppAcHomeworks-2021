require_relative "piece"
require 'singleton'

class NullPiece < Piece
    include Singleton

    def initialize
    end

    def color
        nil
    end

    def symbol
        nil
    end
end