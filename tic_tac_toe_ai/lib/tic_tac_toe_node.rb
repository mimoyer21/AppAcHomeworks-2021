require_relative 'tic_tac_toe'

class TicTacToeNode
    attr_reader :board, :next_mover_mark, :prev_mov_pos

    def initialize(board, next_mover_mark, prev_mov_pos = nil)
        @board = board
        @next_mover_mark = next_mover_mark
        @prev_mov_pos = prev_mov_pos
    end

    def losing_node?(evaluator)
        # base case
        if @board.over?
            if @board.winner.nil? || @board.winner == evaluator
                return false
            else
                return true
            end
        end

        #recursive case
        if next_mover_mark == evaluator
            return true if children.all? { |child| child.losing_node?(evaluator) }
        else
            return true if children.any? { |child| child.losing_node?(evaluator) }
        end

        false
    end

    def winning_node?(evaluator)
        # base case
        if @board.over?
            if @board.winner.nil? || @board.winner != evaluator
                return false
            else
                return true
            end
        end

        #recursive case
        if next_mover_mark == evaluator
            return true if children.any? { |child| child.winning_node?(evaluator) }
        else
            return true if children.all? { |child| child.winning_node?(evaluator) }
        end

        false
    end

  # This method generates an array of all moves that can be made after
  # the current move.
    def children
        kids = []
        if @next_mover_mark == :x
            new_next_mover_mark = :o
        else
            new_next_mover_mark = :x
        end

        (0..2).each do |row_idx|
            (0..2).each do |col_idx|
                pos = [row_idx, col_idx]
                if @board.empty?(pos)
                    new_node = TicTacToeNode.new(@board.dup, new_next_mover_mark, pos)
                    new_node.board[pos] = @next_mover_mark

                    kids << new_node
                end
            end
        end

        kids
    end
end
