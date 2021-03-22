class PolyTreeNode
    attr_reader :value, :parent, :children

    def initialize(value)
        @value = value
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

    def dfs(target_value)
        return self if @value == target_value

        @children.each do |child|
            search_result = child.dfs(target_value)
            return search_result if !search_result.nil?
        end
        
        nil
    end

    def bfs(target_value)
        queue = [self]

        until queue.empty?
            node = queue.shift
            return node if node.value == target_value

            queue += node.children
        end

        nil
    end
end