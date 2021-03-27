require "colorize"
require_relative "cursor"
require_relative "board"

class Display
    attr_reader :board, :cursor

    def initialize(board)
        @board = board
        @cursor = Cursor.new([0,0], board)
    end

    def render
        puts "\n  " + (0..7).to_a.join(" ")
        @board.rows.each.with_index do |row, row_i|
            output = row.map.with_index do |piece, col_i| 
                if @cursor.cursor_pos == [row_i, col_i]
                    if @cursor.selected
                        piece.to_s.on_green
                    else
                        piece.to_s.on_red
                    end
                else
                    piece.to_s 
                end
            end
            output = output.join(" ")
            puts row_i.to_s + " " + output
        end

        nil
    end
end

if __FILE__ == $PROGRAM_NAME
    b = Board.new
    d = Display.new(b)
    # d.looper
    d.render
    b.move_piece(:white,[6,5],[5,5])
    d.render
    b.move_piece(:black,[1,4],[2,4])
    d.render
    b.move_piece(:white,[6,6],[4,6])
    d.render
    b.move_piece(:black,[0,3],[4,7])
    d.render
    # b.move_piece(:white,[6,5],[5,5])
    # d.render

    puts b.in_check?(:white) # true
    puts b.in_check?(:black) # false
end