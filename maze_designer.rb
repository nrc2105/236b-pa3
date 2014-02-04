require_relative 'maze'
require_relative 'node'

class MazeDesigner
	#Takes all relevent maze attributes to restructure
	def initialize(maze)
		@maze = maze
		@width = maze.width
		@height = maze.height
		@nodes = maze.nodes
		@maze_array = maze.maze_array
	end
	#Essentially resets maze, then uses a random DFS to construct new maze, then loads new maze
	def design
		@maze.construct_default_maze_string
		@maze.construct_node_matrix
		connect_all_nodes
		random_depth_first_search(0,0,@nodes.size - 1, @nodes.size - 1)
		create_maze_string
		@maze.load(@maze_string)
	end
	#Creates the final maze string for loading
	def create_maze_string
		convert_array_for_load
		@maze_string = ""
		@maze_array.each{|row| row.each{|element| @maze_string += element}}
	end
	#Converst the array of the maze to 1's and 0's
	def convert_array_for_load
		@maze_array.each do |row| 
			row.each_index do |i|
				row[i] = "1" unless row[i].to_s == " "
				row[i] = "0" if row[i].to_s == " "
			end
		end
	end
	#Performs the random DFS to determine the new maze, backtracking when no way forward exists
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
		made_it = (node == @nodes[endY][endX])
		puts "Final Node = (#{node.x}, #{node.y}) Node reached end: #{made_it}"
	end
	#Determines if there is another node in the adjacency list and if so returns a random one
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
	#Removes a wall between cells
	def knock_down_wall(node1, node2)
		if node1.x == node2.x
			@maze_array[node1.y + node2.y + 1][node1.x * 2 + 1] = " "
		else
			@maze_array[node1.y * 2 + 1][node1.x + node2.x + 1] = " "
		end
	end
	#Connects all nodes to start to allow for DFS
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
	#Connects node to node above
	def connect_above(node)
		above_node = @nodes[node.y - 1][node.x] unless node.y == 0
		node.add_adjacent(above_node)
	end
	#Connects node to node below
	def connect_below(node)
		below_node = @nodes[node.y + 1][node.x] unless node.y + 1 == @nodes.size
		node.add_adjacent(below_node)
	end
	#Connects node to node on left
	def connect_left(node)
		left_node = @nodes[node.y][node.x - 1] unless node.x == 0
		node.add_adjacent(left_node)
	end
	#Connects node to node on right
	def connect_right(node)
		right_node = @nodes[node.y][node.x + 1] unless node.x + 1 == @nodes[0].size
		node.add_adjacent(right_node)
	end
end