#Author: Nicholas Cummins (ncummins@brandeis.edu)

require_relative 'node'

class MazeSolver

	attr_reader :nodes

	#Initialized with the array of nodes from a maze
	def initialize(nodes)
		@nodes = nodes
	end

	#Solve clears all nodes in case of previous solves, and then uses a BFS to indicate if there is a path
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

	#Trace runs solve and uses the predecessor attribute of each node to backtrace the path if there is one
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

	#Clears each node of its 'visited' status and predecessor
	def clear_all
		@nodes.each do |row| 
			row.each do |node| 
				node.clear
			end
		end
	end
end

