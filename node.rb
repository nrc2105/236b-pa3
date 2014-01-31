class Node

	attr_reader :x, :y, :adjacent

	def initialize(x, y)
		@x = x
		@y = y
		@adjacent = []
		@visited = false
	end

	def add_adjacent(node)
		@adjacent << node
	end

	def to_s
		"Node at (#{x},#{y}} Adjacent to #{@adjacent.size}"
	end
end