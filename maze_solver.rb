
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
		node.add_adjacent(@nodes[node.y - 1][node.x]) if @maze_array[node.y * 2][node.x * 2 + 1] == " "
		node.add_adjacent(@nodes[node.y + 1][node.x]) if @maze_array[node.y * 2 + 2][node.x * 2 + 1] == " "
		node.add_adjacent(@nodes[node.y][node.x + 1]) if @maze_array[node.y * 2 + 1][node.x * 2 + 2] == " "
		node.add_adjacent(@nodes[node.y][node.x - 1]) if @maze_array[node.y * 2 + 1][node.x * 2] == " "
	end

	def solve(begX, begY, endX, endY)
		clear_all
		@nodes[begY][begX].visit(nil)
		return @nodes[endY][endX].visited
	end

	def trace(begX, begY, endX, endY)
		node = @nodes[endY][endX]
		if solve(begX, begY, endX, endY)
			begin
				@maze_array[node.y * 2 + 1][node.x * 2 + 1] = "X"
			end while node = node.predecessor
		else
			puts "No Solution"
		end
	end

	def clear_all
		@nodes.each{|row| row.each {|node| node.clear}}
	end
end

