require_relative "player"

class HumanPlayer < Player
    def make_move(board)
        input = []
        
        # gets a start_pos and end_pos from user
        until input.length == 2
            cur_input = self.display.cursor.get_input
            input << cur_input unless cur_input.nil?
            self.display.render
        end

        start_pos, end_pos = input

        board.move_piece(self.color, start_pos, end_pos)
            
        rescue => exception
            puts exception.message
            puts "Try another move"
            self.display.render
            retry
    end
end