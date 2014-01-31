
require_relative 'node'

class MazeSolver

	attr_reader :nodes
	def initialize(width, height, maze)
		@maze_array = maze
		@width = (width - 1) / 2
		@height = (height - 1) /2
		@nodes = Array.new(@height){Array.new(@width)}
		construct_graph
	end

	def construct_graph
		@nodes.each_index{|j| @nodes[j].each_index{|i| @nodes[j][i] = Node.new(i, j)}}
		@nodes.each_index{|j| @nodes[j].each_index{|i| find_adjacent(@nodes[j][i])}}
	end

	def find_adjacent(node)
		puts "To the left of (#{node.x}, #{node.y}) is#{@maze_array[node.y * 2 + 1][node.x * 2]}"
		node.add_adjacent(@nodes[node.y - 1][node.x]) if @maze_array[node.y * 2][node.x * 2 + 1] == "0"
		node.add_adjacent(@nodes[node.y + 1][node.x]) if @maze_array[node.y * 2 + 2][node.x * 2 + 1] == "0"
		node.add_adjacent(@nodes[node.y][node.x + 1]) if @maze_array[node.y * 2 + 1][node.x * 2 + 2] == "0"
		node.add_adjacent(@nodes[node.y][node.x - 1]) if @maze_array[node.y * 2 + 1][node.x * 2] == "0"
	end

	def solve(begX, begY, endX, endY)
	end
end

