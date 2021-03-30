require 'rspec'
require 'hanoi_tower_game'

describe HanoiTowerGame do
    subject(:game) { HanoiTowerGame.new }

    describe "#initialize" do
        it "creates a tower with all discs on the first stack in descending order (from bottom up)" do
            expect(game.towers.first).to eq([4,3,2,1])
        end

        it "has the 2nd and 3rd stacks empty" do
            expect(game.towers[1]).to be_empty
            expect(game.towers[2]).to be_empty
        end
    end

    describe "#move" do
        before(:each) { game.move }    

        it "adds the top disc to the selected stack" do
            expect(game.towers[1]).to eq([1])
        end

        it "removes the top disc from the first selected stack" do
            expect(game.towers[0]).to eq([4,3,2])
        end
    end

    describe "#won?" do
        it "returns false at the start of the game" do
            expect(game.won?).to be false
        end

        # it "returns true if all discs are in the last stack" do
        #     # game.move
        #     # game.move
        #     # game.move
        #     # game.move
        #     # game.move
        #     # expect(won_game.won?).to be true
        # end
    end
end

