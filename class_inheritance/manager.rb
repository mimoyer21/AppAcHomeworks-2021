require_relative "employee"

class Manager < Employee

    def initialize(name, title, salary, boss=nil)
        super

        @employees = []
    end

    def add_subordinate(employee)
        @employees << employee
    end

    def salary_of_subs
        return 0 if @employees.empty?

        sum_salary = 0
        @employees.each do |empl|
            sum_salary += empl.salary
            sum_salary += empl.salary_of_subs if empl.is_a?(Manager)
        end

        sum_salary
    end

    def bonus(multiplier)
        salary_of_subs * multiplier
    end
end

if __FILE__ == $PROGRAM_NAME
    ned = Manager.new("Darren", "TA Mgr", 78000, nil)
    darren = Manager.new("Darren", "TA Mgr", 78000, ned)
    shawna = Employee.new("Shawna", "TA", 12000, darren)
    david = Employee.new("David", "TA", 10000, darren)

    p ned.bonus(5) # => 500_000
    p darren.bonus(4) # => 88_000
    p david.bonus(3) # => 30_000
end