require_relative "piece"
require_relative "king"
require_relative "queen"
require_relative "rook"
require_relative "bishop"
require_relative "knight"
require_relative "pawn"
require_relative "null_piece"


class Board
    attr_accessor :rows

    def initialize
        @null_piece = NullPiece.instance

        back_row_black = [ Rook.new(:black, self, [0,0]), Knight.new(:black, self, [0,1]), Bishop.new(:black, self, [0,2]), Queen.new(:black, self, [0,3]), King.new(:black, self, [0,4]), Bishop.new(:black, self, [0,5]), Knight.new(:black, self, [0,6]), Rook.new(:black, self, [0,7])]
        front_row_black = (0..7).each.map { |i| Pawn.new(:black, self, [1,i]) }
        empty_middle_rows = Array.new(4) { Array.new(8, @null_piece) }
        front_row_white = (0..7).each.map { |i| Pawn.new(:white, self, [6,i]) }
        back_row_white = [ Rook.new(:white, self, [7,0]), Knight.new(:white, self, [7,1]), Bishop.new(:white, self, [7,2]), Queen.new(:white, self, [7,3]), King.new(:white, self, [7,4]), Bishop.new(:white, self, [7,5]), Knight.new(:white, self, [7,6]), Rook.new(:white, self, [7,7])]

        @rows = []
        @rows << back_row_black
        @rows << front_row_black
        @rows += empty_middle_rows
        @rows << front_row_white
        @rows << back_row_white
    end

    def [](pos)
        row, col = pos

        @rows[row][col]
    end

    def []=(pos, val)
        row, col = pos
        
        @rows[row][col] = val
    end

    def move_piece(color, start_pos, end_pos)
        if self[start_pos].is_a?(NullPiece)
            raise "No piece at that start_pos"
        elsif self[start_pos].color != color
            raise "That piece isn't yours"
        elsif !valid_pos?(end_pos)
            raise "end_pos not on board" 
        elsif color == self[end_pos].color
            raise "Already a #{color} piece in that end_pos"
        elsif !self[start_pos].valid_moves.include?(end_pos)
            raise "That piece can't move there. Make sure it wouldn't leave you in check"
        end

        self[end_pos] = self[start_pos] # move piece
        self[end_pos].pos = end_pos

        self[start_pos] = @null_piece # set original position empty

        true
    end

    # moves piece regardless of whether it's a valid move. This is used for moving a piece on our duped board to see *if* the move would put the player into check
    def move_piece!(color, start_pos, end_pos)
        if self[start_pos].is_a?(NullPiece)
            raise "No piece at that start_pos"
        elsif self[start_pos].color != color
            raise "That piece isn't yours"
        elsif !valid_pos?(end_pos)
            raise "end_pos not on board" 
        elsif color == self[end_pos].color
            raise "Already a #{color} piece in that end_pos"
        # elsif !self[start_pos].valid_moves.include?(end_pos)
        #     raise "That piece can't move there. Make sure it wouldn't leave you in check"
        end

        self[end_pos] = self[start_pos] # move piece
        self[end_pos].pos = end_pos

        self[start_pos] = @null_piece # set original position empty

        true
    end

    def valid_pos?(pos)
        pos.all? { |i| i.between?(0,7) }
    end

    def in_check?(color)
        king_pos = []
        @rows.each.with_index do |row, row_i|
            col_i = row.index { |piece| piece.is_a?(King) && piece.color == color }
            if !col_i.nil?
                king_pos = [row_i, col_i]
                break
            end
        end

        @rows.flatten.each do |piece|
            return true if !piece.is_a?(NullPiece) && piece.moves.include?(king_pos)
        end

        false
    end

    def checkmate?(color)
        return false if !in_check?(color)

        my_pieces = @rows.flatten.select { |piece| piece.color == color }
        my_pieces.none? { |piece| piece.valid_moves.length >= 1 }
    end

    def dup
        new_board = Board.new
        new_board.rows = self.rows.map do |row|
            row.map do |piece| 
                if piece.is_a?(NullPiece)
                    piece
                else
                    piece_type = piece.class.to_s
                    new_piece_values = [piece.color, new_board, piece.pos] 
                    case piece_type
                    when "Rook"
                        Rook.new(*new_piece_values)
                    when "Knight"
                        Knight.new(*new_piece_values)
                    when "Bishop"
                        Bishop.new(*new_piece_values)
                    when "Queen"
                        Queen.new(*new_piece_values)
                    when "King"
                        King.new(*new_piece_values)
                    when "Pawn"
                        Pawn.new(*new_piece_values)
                    end
                end
            end
        end

        new_board
    end
end

if __FILE__ == $PROGRAM_NAME
    # put test code here
    b = Board.new
    p b

    duped = b.dup

    puts
    puts
    p b
    puts
    puts
    p duped
end