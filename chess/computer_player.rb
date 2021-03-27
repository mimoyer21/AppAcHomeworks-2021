require_relative "player"

class ComputerPlayer < Player
    def make_move(board)
        my_pieces = board.rows.flatten.select { |piece| piece.color == self.color }
        
        moves = []
        attacking_moves = []

        # find all moves for my pieces. store separate array of attacking moves
        my_pieces.each do |piece|
            start_pos = piece.pos
            moves += piece.valid_moves.map { |move| [start_pos, move] }
            attacking_move_pos = piece.valid_moves.select { |move| !board[move].color.nil? && board[move].color != self.color }
            attacking_moves += attacking_move_pos.map { |move| [start_pos, move] }
        end

        my_move = nil

        # take a random attacking move, if avail. otherwise take a random move
        if !attacking_moves.empty?
            my_move = attacking_moves.sample
        else
            my_move = moves.sample
        end

        board.move_piece(self.color, *my_move)
    end
end