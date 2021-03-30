require 'rspec'
require 'tdd'

describe "array functions" do
  subject(:my_arr) { [1,3,1,-3,5,-1] }
  let(:my_2d_arr) { [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8]
  ] }

  describe "#my_uniq" do
    it "returns a new array without duplicates" do
        expect(my_arr.my_uniq).to match_array(my_arr.uniq)
    end

    it "maintains the order from original aray" do
        expect(my_arr.my_uniq).to eq([1,3,-3,5,-1])
    end
  end

  describe "#two_sum" do
    it "returns all pairs of positions where the elements at those positions sum to zero" do 
        expect(my_arr.two_sum).to contain_exactly([-3,3], [-1,1])
    end

    it "has each pair sorted smaller index before bigger index" do
        each_pair_is_sorted = my_arr.two_sum.all? { |pair| pair[0] <= pair[1] }
        expect(each_pair_is_sorted).to be true
    end

    it "has all pairs sorted dictionary-style" do
        arr = my_arr.two_sum
        arr_is_sorted = (0...arr.length-1).all? do |i|
            if arr[i] == arr[i+1][0] # if first el matches
                arr[i][1] <= arr[i+1][1]
            else
                arr[i][0] < arr[i+1][0] 
            end
        end
        expect(arr_is_sorted).to be true
    end

  end

  describe "#my_transpose" do
    let(:non_sq_arr) { [[1,2,3], [4,5,6]] }
    it "raises an error if the 2d array isn't square" do
        expect { non_sq_arr.my_transpose }.to raise_error("This isn't a square 2d array")
    end

    it "transposes the rows of a 2d array into columns" do
        expect(my_2d_arr.my_transpose).to eq([[0, 3, 6],
                                   [1, 4, 7],
                                   [2, 5, 8]])
    end
  end

  describe "#stock_picker" do
    it "returns the pair of days that is most profitable (in absolute $) to buy and then sell a stock" do
        expect(my_arr.stock_picker).to eq([3,4])
    end

    it "has a sell day that is after the buy day" do
        expect(my_arr.stock_picker.first).to be < my_arr.stock_picker[1]
    end
  end
end
