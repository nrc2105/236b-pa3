
require_relative 'node'

class MazeSolver
	DIRECTIONS = [:up, :down, :left, :right]
	attr_reader :nodes
	def initialize(nodes, maze)
		@maze_array = maze
		#@width = (width - 1) / 2
		#@height = (height - 1) /2
		@nodes = nodes
		#construct_graph
	end

	def construct_node_matrix
		@nodes.each_index{|j| @nodes[j].each_index{|i| @nodes[j][i] = Node.new(i, j)}}
		@nodes.each_index{|j| @nodes[j].each_index{|i| find_adjacent(@nodes[j][i])}}
	end

	def find_adjacent(node)
		node.adjacent << above(node) if (path(node, above(node)))
		node.adjacent << below(node) if (path(node, below(node)))
		node.adjacent << right(node) if (path(node, right(node)))
		node.adjacent << left(node)  if (path(node, left(node)))
	end

	def above(node)
		@nodes[node.y - 1][node.x] unless node.y - 1 < 0
	end

	def below(node)
		@nodes[node.y + 1][node.x] unless node.y + 1 >= @height
	end

	def left(node)
		@nodes[node.y][node.x - 1] unless node.x - 1 < 0
	end

	def right(node)
		@nodes[node.y][node.x + 1] unless node.x + 1 >= @width
	end

	def path(node1, node2)
		return false if node1 == nil or node2 == nil
		if node1.x == node2.x 
			(@maze_array[node1.y + node2.y + 1][node1.x * 2 + 1] == " ")
		else
			(@maze_array[node1.y * 2 + 1][node1.x + node2.x + 1] == " ")
		end
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
				@maze_array[node.y * 2 + 1][node.x * 2 + 1] = "X"
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

