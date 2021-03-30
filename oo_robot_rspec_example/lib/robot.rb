class Robot
    attr_accessor :equipped_weapon
    attr_reader :position, :items, :health

    def initialize
        @position = [0,0]
        @items = []
        @health = 100
        @equipped_weapon = nil
    end

    def move_left
        x,y = @position
        @position = [x - 1, y]
    end

    def move_right
        x,y = @position
        @position = [x + 1, y]
    end

    def move_up
        x,y = @position
        @position = [x, y + 1]
    end

    def move_down
        x,y = @position
        @position = [x, y - 1]
    end

    def pick_up(item)
        raise ArgumentError if items_weight >= 250
        
        @items << item
    end

    def items_weight
        @items.map { |item| item.weight }.sum
    end

    def wound(damage)
        if @health - damage < 0
            @health = 0
        else
            @health -= damage
        end
    end

    def heal(amount)
        if @health + amount > 100
            @health = 100
        else
            @health += amount
        end
    end

    def attack(other_robot)
        if @equipped_weapon
            @equipped_weapon.hit(other_robot)
        else
            other_robot.wound(5) # default attack
        end
    end
end

class Item
    attr_reader :name, :weight

    def initialize(name, weight)
        @name = name
        @weight = weight
    end

end

class Bolts < Item

    def initialize
        super("bolts", 25)
    end

    def feed(robot)
        robot.heal(25)
    end
end

class Weapon < Item
    attr_reader :damage 
    
    def initialize(name, weight, damage)
        super(name, weight)
        @damage = damage
    end

    def hit(robot)
        robot.wound(damage)
    end
end


class Laser < Weapon
    def initialize
        super("laser", 125, 25)
    end
end

class PlasmaCannon < Weapon
    def initialize
        super("plasma_cannon", 200, 55)
    end
end