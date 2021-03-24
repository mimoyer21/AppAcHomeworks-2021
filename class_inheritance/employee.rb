class Employee
    attr_reader :name, :title, :salary, :boss

    def initialize(name, title, salary, boss=nil)
        @name = name
        @title = title
        @salary = salary
        @boss = boss

        @boss.add_subordinate(self) if !boss.nil?
    end

    def bonus(multiplier)
        @salary * multiplier
    end
end