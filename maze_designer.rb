require_relative 'maze'
require_relative 'node'

class MazeDesigner

	def initialize(maze)
		@maze = maze
		@width = maze.width
		@height = maze.height
		@nodes = maze.nodes
	end

	def design
		@maze.construct_default_maze_string
		@maze.construct_node_matrix
		connect_all_nodes

		#maze_string = "1" * width
		#for i in 0..((height * width) - 2 * width - 1)
	#		maze_string += rand(2).to_s unless i % width == 0 or i % width == width - 1
	#		maze_string += "1" if i % width == 0 or i % width == width - 1  
	#	end
	#	return maze_string += "1" * width

	end

	def connect_all_nodes
		@nodes.each do |row|
			row.each do |node|
			connect_above(node)
			connect_below(node)
			connect_left(node)
			connect_right(node)
			end
		end
	end

	def connect_above(node)
		above_node = @nodes[node.y - 1][node.x] unless node.y == 0
		node.add_adjacent(above_node)
	end

	def connect_below(node)
		below_node = @nodes[node.y + 1][node.x] unless node.y + 1 == @nodes.size
		node.add_adjacent(below_node)
	end

	def connect_left(node)
		left_node = @nodes[node.y][node.x - 1] unless node.x == 0
		node.add_adjacent(left_node)
	end

	def connect_right(node)
		right_node = @nodes[node.y][node.x + 1] unless node.x + 1 == @nodes[0].size
		node.add_adjacent(right_node)
	end


end