class Node
	attr_accessor :node_string
	attr_reader :x, :y,:adjacent, :predecessor, :visited
	#Nodes store their locations, as well as all adjacent nodes, predecessor, and a visited boolean
	def initialize(x, y)
		@x = x
		@y = y
		@adjacent = []
		@predecessor = nil
		@visted = false
		@node_string = " "
	end

	#Adds the node argument to the array of adjacent nodes
	def add_adjacent(node)
		@adjacent << node unless node == nil
	end

	#A visit by the predecessor updates the predecessor and visited attributes
	def visit(predecessor)
		@predecessor = predecessor
		@visited = true
	end

	#Resets the node to nil predecessor, false on visited, and a space for a string
	def clear
		@predecessor = nil
		@visited = false
		@node_string = " "
	end

	#Used by the maze to display the node, it is a space by default
	def to_s
		@node_string
	end
end