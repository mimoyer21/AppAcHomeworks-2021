require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
    def move(game, mark)
        board = game.board
        node = TicTacToeNode.new(board, mark)
        
        non_losing_move = nil

        node.children.each do |child|
            return child.prev_mov_pos if child.winning_node?(mark)
            non_losing_move = child.prev_mov_pos if !child.losing_node?(mark)
        end

        raise "No non-losing moves! This shouldn't happen" if non_losing_move.nil?

        non_losing_move
    end
end

if __FILE__ == $PROGRAM_NAME
    puts "Play the brilliant computer!"
    hp = HumanPlayer.new("Jeff")
    cp = SuperComputerPlayer.new

    TicTacToe.new(hp, cp).run
end
