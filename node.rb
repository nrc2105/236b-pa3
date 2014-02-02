class Node

	attr_reader :x, :y,:adjacent, :predecessor, :visited
	def initialize(x, y)
		@x = x
		@y = y
		@adjacent = []
		@predecessor = nil
		@visted = false
	end

	def add_adjacent(node)
		@adjacent << node unless node == nil
	end

	def visit(predecessor)
		@predecessor = predecessor
		@visited = true
	end

	def clear
		@predecessor = nil
		@visited = false
	end

	def to_s
		"Node at (#{x},#{y}} Adjacent to #{@adjacent.size}"
	end
end