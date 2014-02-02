
require_relative 'node'

class MazeSolver
	DIRECTIONS = [:up, :down, :left, :right]
	attr_reader :nodes
	def initialize(nodes, maze)
		@maze_array = maze
		@nodes = nodes
	end

	def solve(begX, begY, endX, endY)
		clear_all
		@nodes[begY][begX].visit(nil)
		bfs_array = [@nodes[begY][begX]]
		while bfs_array.size > 0
			current_node = bfs_array.shift
			current_node.adjacent.each do |child_node|
				bfs_array << child_node if !child_node.visited
				child_node.visit(current_node) if !child_node.visited
			end
		end
		return @nodes[endY][endX].visited
	end

	def trace(begX, begY, endX, endY)
		clear_all
		node = @nodes[endY][endX]
		if solve(begX, begY, endX, endY)
			begin
				node.node_string = "X"
			end while node = node.predecessor
		else
			puts "No Solution"
		end
	end

	def clear_all
		@nodes.each do |row| 
			row.each do |node| 
				node.clear
				#@maze_array[node.y * 2 + 1][node.x * 2 + 1] = " "
			end
		end
	end
end

