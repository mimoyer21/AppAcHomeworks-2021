class Simon
    COLORS = %w(red blue green yellow)

    attr_accessor :sequence_length, :game_over, :seq

    def initialize
        @sequence_length = 1
        @game_over = false
        @seq = []
    end

    def play
        take_turn until @game_over

        game_over_message
        reset_game            
    end

    def take_turn
        show_sequence
        require_sequence

        if !@game_over
            round_success_message 
            @sequence_length += 1
        end
    end

    def show_sequence
        puts add_random_color
    end

    def require_sequence
        input = []
        puts "Enter colors, one by one"
        until input.length == @seq.length || @game_over
            input << gets.chomp
            if @seq[0...input.length] != input
                @game_over = true 
                return
            end
        end
    end

    def add_random_color
        new_color = COLORS.sample
        @seq << new_color
        
        new_color
    end

    def round_success_message
        puts "That's right! On to the next round..."
    end

    def game_over_message
        puts "WRONG! The right pattern was #{@seq}. Better luck next time."
    end

    def reset_game
        @sequence_length = 1
        @game_over = false
        @seq = []
    end
end
