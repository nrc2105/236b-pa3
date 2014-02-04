require_relative 'maze'
require_relative 'node'

class MazeDesigner

	def initialize(maze)
		@maze = maze
		@width = maze.width
		@height = maze.height
		@nodes = maze.nodes
		@maze_array = maze.maze_array
	end

	def design
		@maze.construct_default_maze_string
		@maze.construct_node_matrix
		connect_all_nodes
		random_depth_first_search(0,0,@nodes.size[0] - 1, @nodes.size - 1)
	end

	def random_depth_first_search(startX, startY, endX, endY)
		node = @nodes[startY][startX]
		while node != @nodes[endY][endX]
			if (next_node = find_next(node))
				next_node.visit(node)
				knock_down_wall(node, next_node)
				node = next_node
			else
				node = node.predecessor
			end
		end
	end

	def find_next(node)
		while node.adjacent.size > 0
			next_node = node.adjacent[rand(node.adjacent.size)]
			if next_node.visited
				node.adjacent.delete(next_node)
			else
				return next_node
			end
		end

		return false
	end

	def knock_down_wall(node1, node2)
		if node1.x == node2.x
			@maze_array[node1.y + node2.y + 1][node1.x * 2 + 1] = " "
		else
			@maze_array[node1.y * 2 + 1][node1.x + node2.x + 1] = " "
		end
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