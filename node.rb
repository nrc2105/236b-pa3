class Node
	attr_accessor :node_string
	attr_reader :x, :y,:adjacent, :predecessor, :visited
	def initialize(x, y)
		@x = x
		@y = y
		@adjacent = []
		@predecessor = nil
		@visted = false
		@node_string = " "
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
		@node_string = " "
	end

	def to_s
		@node_string
	end
end