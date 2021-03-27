require_relative "board"
require_relative "display"
require_relative "human_player"
require_relative "computer_player"

class Game

    def initialize
        @board = Board.new
        @display = Display.new(@board)
        @players = [ ComputerPlayer.new(:white,@display), HumanPlayer.new(:black,@display) ]
        # @players = [ player1, player2 ]
        @current_player = @players.first
    end

    def play
        until @board.checkmate?(@current_player.color)
            @display.render
            notify_players
            @current_player.make_move(@board)

            swap_turn!
        end

        puts "Game over. #{@current_player.color} is in checkmate. Final board:"
        @display.render
    end

    private
    def notify_players
        puts "#{@current_player.color}'s turn. Make your move:"
    end

    def swap_turn!
        @players.rotate!
        @current_player = @players.first
    end
end

if __FILE__ == $PROGRAM_NAME
    g = Game.new
    g.play
end