require_relative 'poly_tree_node.rb'

class KnightPathFinder
    attr_reader :root_node
    
    @@deltas = [[-1,-2], [-1,2], [1,-2], [1,2], [-2,-1], [-2,1], [2,-1], [2,1]]
    
    def self.valid_moves(pos)
        end_pos = @@deltas.map do |delta|
            x = pos[0] + delta[0]
            y = pos[1] + delta[1]
            [x,y]
        end

        end_pos.select { |p| p[0].between?(0,7) && p[1].between?(0,7) }
    end
    
    def initialize(starting_pos)
        @root_node = PolyTreeNode.new(starting_pos)
        @considered_positions = [starting_pos]
    end

    def new_move_positions(pos)
        new_pos = KnightPathFinder.valid_moves(pos) - @considered_positions
        @considered_positions += new_pos
        
        new_pos
    end

    def build_move_tree
        queue = [@root_node]

        until queue.empty?
            node = queue.shift
            new_positions = new_move_positions(node.position)
            new_positions.each do |pos|
                new_node = PolyTreeNode.new(pos)
                new_node.parent = node
                queue << new_node
            end
        end
    end

    def find_path(end_pos)
        end_node = @root_node.bfs(end_pos)
        
        trace_path_back(end_node)
    end

    def trace_path_back(end_node)
        node = end_node
        path = []

        until node.nil?
            path.unshift(node.position)
            node = node.parent
        end      
        
        path
    end
end