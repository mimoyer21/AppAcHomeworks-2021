# Remove dups
# Array has a uniq method that removes duplicates from an array. It returns the unique elements in the order in which they first appeared:
class Array
# [1, 2, 1, 3, 3].uniq # => [1, 2, 3]
# Write your own version of this method called my_uniq; it should take in an Array and return a new array.
    def my_uniq
        new_arr = []
        self.each { |el| new_arr << el if !new_arr.include?(el) }

        new_arr
    end


# Two sum
# Write a new Array#two_sum method that finds all pairs of positions where the elements at those positions sum to zero.
    def two_sum
        pairs = []
        (0...self.length).each do |i1|
            (i1+1...self.length).each do |i2|
                first = self[i1]
                second = self[i2]

                pairs << [first, second].sort if first + second == 0
            end
        end

        pairs.sort.uniq
    end
# NB: ordering matters. We want each of the pairs to be sorted smaller index before bigger index. We want the array of pairs to be sorted "dictionary-wise":

# [-1, 0, 2, -2, 1].two_sum # => [[0, 4], [2, 3]]
# [0, 2] before [2, 1] (smaller first elements come first)
# [0, 1] before [0, 2] (then smaller second elements come first)

# My Transpose
# To represent a matrix, or two-dimensional grid of numbers, we can write an array containing arrays which represent rows:

# rows = [
#     [0, 1, 2],
#     [3, 4, 5],
#     [6, 7, 8]
#   ]

# row1 = rows[0]
# row2 = rows[1]
# row3 = rows[2]
# We could equivalently have stored the matrix as an array of columns:

# cols = [
#     [0, 3, 6],
#     [1, 4, 7],
#     [2, 5, 8]
#   ]
# Write a method, my_transpose, which will convert between the row-oriented and column-oriented representations. You may assume square matrices for simplicity's sake. Usage will look like the following:
    def my_transpose
        raise "This isn't a square 2d array" if self.length != self.first.length

        new_arr = []
        (0...self.length).each do |col_i|
            new_row = []
            (0...self.length).each do |row_i|
                new_row << self[row_i][col_i]
            end
            new_arr << new_row
        end

        new_arr
    end

# my_transpose([
#     [0, 1, 2],
#     [3, 4, 5],
#     [6, 7, 8]
#   ])
#  => [[0, 3, 6],
#     [1, 4, 7],
#     [2, 5, 8]]

# Stock Picker
# Write a method that takes an array of stock prices (prices on days 0, 1, ...), and outputs the most profitable pair of days on which to first buy the stock and then sell the stock. Remember, you can't sell stock before you buy it!
    def stock_picker
        best_pair = []

        (0...self.length).each do |i1|
            (i1+1...self.length).each do |i2|
                if best_pair.empty?
                    best_pair = [i1, i2]
                    next
                end
                cur_buy_day = best_pair[0]
                cur_sell_day = best_pair[1]
                cur_gain = self[cur_sell_day] - self[cur_buy_day]
                new_gain = self[i2] - self[i1]

                best_pair = [i1, i2] if new_gain > cur_gain
            end
        end

        best_pair
    end
end
# Towers of Hanoi
# Write a Towers of Hanoi game.

# Keep three arrays, which represents the piles of discs. Pick a representation of the discs to store in the arrays; maybe just a number representing their size. Don't worry too much about making the user interface pretty.

# In a loop, prompt the user (using gets) and ask what pile to select a disc from, and where to put it.

# After each move, check to see if they have succeeded in moving all the discs, to the final pile. If so, they win!

# Note: don't worry about testing the UI. Testing console I/O is tricky (don't bother checking gets or puts). Focus on:

# #move
# #won?