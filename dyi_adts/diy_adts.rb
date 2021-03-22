# Exercise 1 - Stack
# Let's write a Stack class. To do this, use the following framework:

class Stack
    def initialize
        @stack = []
    end

    def push(el)
        @stack << el
    end

    def pop
        @stack.pop
    end

    def peek
        @stack.last
    end
end


# To test that your code works, create a new instance of the Stack class, and play around with adding and removing elements. Remember, a stack follows the principle of LIFO!
# s = Stack.new
# s.push(3)
# s.push("horse")
# s.push(45)

# p s.peek # 45
# p s.pop # 45
# p s.peek # "horse"

# Exercise 2 - Queue
# Now let's write a Queue class. We will need the following instance methods: enqueue(el), dequeue, and peek.
class Queue

    def initialize
        @queue = []
    end

    def enqueue(el)
        @queue << el
    end

    def dequeue
        @queue.shift
    end

    def peek
        @queue.first
    end
end

# Test your code to ensure it follows the principle of FIFO.
# q = Queue.new
# q.enqueue(2)
# q.enqueue(5)
# q.enqueue(1)

# p q.peek
# p q.dequeue
# p q.dequeue


# Exercise 3 - Map
# As you saw in the videos for tonight, a map can be implemented using a 2D array. Let's write a Map class (following a similar pattern to Stack and Queue) that implements a map using only arrays.

# Remember, a map stores information in key-value pairs, where the keys are always unique. When implemented with arrays, a map might look something like this: my_map = [[k1, v1], [k2, v2], [k3, v2], ...].

# Our Map class should have the following instance methods: set(key, value), get(key), delete(key), show. Note that the set method can be used to either create a new key-value pair or update the value for a pre-existing key. It's up to you to check whether a key currently exists!
class Map
    def initialize
        @map = []
    end

    def set(key, value)
        if @map.any? { |pair| pair[0] == key }
            idx = @map.index { |pair| pair[0] == key }
            @map[idx] = [key, value]
        else
            @map << [key, value]
        end
    end 
    
    def get(key)
        my_pair = @map.select { |pair| pair[0] == key }
        my_pair[0][1]
    end
    
    def delete(key)
        @map.delete_if { |pair| pair[0] == key }
    end
    
    def show
        p @map
    end
end

# As always, test your code thoroughly to make sure all properties of maps are enforced.
m = Map.new
m.set("name", "Mike")
m.set("age", 29)

m.show

p m.get("name")
p m.delete("name")
m.show
m.set("age", 99)

m.show