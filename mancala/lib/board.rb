class Board
  attr_accessor :cups

  def initialize(name1, name2)
    @cups = Array.new(14) { [] }
    place_stones

    @name1, @name2 = name1, name2
  end

  def place_stones
    # helper method to #initialize every non-store cup with four stones each
    @cups.map!.with_index do |cup, i| 
        if i == 6 || i == 13 # set the two stores empty
            []
        else
            Array.new(4,:stone)
        end
    end 

  end

  def valid_move?(start_pos)
    raise 'Invalid starting cup' unless start_pos.between?(0,5) || start_pos.between?(7,12)
    raise 'Starting cup is empty' if @cups[start_pos].empty?
  end

  def make_move(start_pos, current_player_name)
    cur_pos = start_pos
    stones = @cups[start_pos]
    @cups[start_pos] = []

    current_side = current_player_name == @name1 ? 1 : 2
    other_player_store = current_side == 1 ? 13 : 6

    until stones.empty?
        if cur_pos == 13
           cur_pos = 0 # make the board circular by having 13=>0
        else
            cur_pos += 1
        end
        @cups[cur_pos] << stones.pop unless cur_pos == other_player_store # don't place a stone in the other player's store
    end
    
    render
    next_turn(cur_pos)
  end

  def next_turn(ending_cup_idx)
    # helper method to determine whether #make_move returns :switch, :prompt, or ending_cup_idx
    if ending_cup_idx == 6 || ending_cup_idx == 13 # ended on points cup
        return :prompt
    elsif @cups[ending_cup_idx].size == 1 # ended on an empty cup
        return :switch
    else
        return ending_cup_idx
    end
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
    @cups[0..5].all?(&:empty?) || @cups[7..12].all?(&:empty?) 
  end

  def winner 
    player1_score = @cups[6].size
    player2_score = @cups[13].size
    
    case player1_score <=> player2_score
    when -1
        return @name2
    when 0 
        return :draw
    when 1
        return @name1
    end
  end
end
