class HanoiTowerGame
    attr_reader :towers

    def initialize
        @towers = [
            [4,3,2,1],
            [],
            []
        ]
    end

    def move
        puts "Select which tower to move a piece FROM [1, 2, or 3]:"
        begin
            start_tower = gets.chomp.to_i - 1
            valid_start_tower(start_tower)
        rescue => exception
            puts exception.message
            puts "Try again (1, 2, or 3):"
            retry            
        end

        avail_end_towers = [1,2,3].reject { |idx| idx == start_tower + 1 }

        begin
            puts "Select which tower to move a piece TO #{avail_end_towers}:"
            end_tower = gets.chomp.to_i - 1
            valid_end_tower(start_tower, end_tower)
        rescue => exception
            puts exception.message
            puts "Try again #{avail_end_towers}:"
            retry            
        end

        @towers[end_tower] << @towers[start_tower].pop
    end

    def won?
        if @towers[2] == [4,3,2,1]
            return true
        else 
            return false
        end
    end

    def play
        puts "Your goal is to stack the discs onto the 3rd stack"
        until won?
            puts "Current towers:"
            p @towers

            move
        end

        puts "You win!"
    end

    private
    def valid_start_tower(i)
        is_valid_idx = [0,1,2].include?(i) 
        raise "Must enter 1, 2, or 3" if !is_valid_idx

        tower_has_disc = !@towers[i].empty?
        raise "That tower doesn't have any discs" if !tower_has_disc

        # has another stack to move the piece to
        other_towers = [0,1,2].reject { |idx| idx == i }
        avail_move = other_towers.any? do |idx|
            @towers[idx].empty? || @towers[i].last < @towers[idx].last
        end

        raise "There's no place to put that disc" if !avail_move

        true
    end

    def valid_end_tower(start_tower, end_tower)
        is_valid_idx = [0,1,2].include?(end_tower) 
        raise "Must enter 1, 2, or 3" if !is_valid_idx

        disc = @towers[start_tower].last

        raise "Can't put a larger disc on a smaller disc" if !@towers[end_tower].empty? && disc > @towers[end_tower].last

        true
    end
end