class PolyTreeNode
    attr_reader :position, :parent, :children

    def initialize(position)
        @position = position
        @parent = nil
        @children = []
    end

    def parent=(new_parent)
        old_parent = @parent
        old_parent.children.delete(self) if !old_parent.nil?

        @parent = new_parent

        new_parent.children << self if !new_parent.nil? && !new_parent.children.include?(self)
    end

    def add_child(child_node)
        child_node.parent = self
    end

    def remove_child(child_node)
        raise "Not a child" if !@children.include?(child_node)

        child_node.parent = nil
    end

    def dfs(target_pos)
        return self if @position == target_pos

        @children.each do |child|
            search_result = child.dfs(target_pos)
            return search_result if !search_result.nil?
        end
        
        nil
    end

    def bfs(target_pos)
        queue = [self]

        until queue.empty?
            node = queue.shift
            return node if node.position == target_pos

            queue += node.children
        end

        nil
    end
end