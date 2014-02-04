require_relative "maze_solver"
require_relative "node"
require_relative "maze_designer"

class Maze

	attr_reader :maze_solver, :maze_array, :nodes, :width, :height
	#Initializes the maze with size allowing for walls around all 'chambers'
	def initialize (n,m)
		@cell_width = n
		@cell_height = m
		@width = n*2 + 1
		@height = m*2 + 1
		construct_default_maze_string
		@maze_array = Array.new(@height){Array.new(@width){0}}
		@nodes = Array.new(@cell_height){Array.new(@cell_width)}
	end

	#Loads a string of 1s and 0s into the maze_array, then calls the methods to construct the appropriate matrices
	def load(arg)
		raise RuntimeError.new("Wrong size") if arg.size != @width*@height
		maze_format(arg)
		construct_node_matrix
		find_node_adjacency
		@maze_solver = MazeSolver.new(@nodes)
	end

	#Using the string from load this method builds a matrix of Nodes representing cells and superimposes it on the maze array
	def construct_node_matrix
		string_to_maze_matrix
		@nodes.each_with_index{|row, j| row.each_index{|i| row[i] = Node.new(i, j)}}
		@maze_array.each_with_index{|row, j| row.each_index {|i| row[i] = @nodes[(j-1)/2][(i-1)/2] if j.odd? and i.odd?}}
	end

	#Converts the maze_string to a matrix for solving and displaying
	def string_to_maze_matrix
		@maze_string.chars.each_index {|c| @maze_array[c / @width][c % @width] = @maze_string[c]}
	end
	
	#Goes through entire maze and determines which cells are connected
	def find_node_adjacency
		@maze_array.each_with_index do |row, j|
			row.each_with_index do |element, i|
				connect(@maze_array[j - 1][i], @maze_array[j + 1][i]) if element == " "
				connect(row[i -1], row[i + 1]) if element == " "
			end
		end
	end

	#If it has been determined that there is a path between two adjacent nodes they are linked
	def connect(node1, node2)
		if node1.class == Node
			node1.add_adjacent(node2)
			node2.add_adjacent(node1)
		end
	end

	#Constructs the default look of the maze, with '+-' for horizonal walls and '|' for vertical walls
	def construct_default_maze_string
		top = "+-" * @cell_width + "+"
		body = "|" + (" |" * @cell_width)
		@maze_string = top + (body + top) * @cell_height
	end

	#Takes walls out of the predefined maze (Which has four walls on every cell)
	def maze_format(arg)
		arg.chars.each_index {|c| @maze_string[c] = " " if arg[c] == "0"}
	end

	#Displays the maze
	def display
		output = ""
		@maze_array.each do |line|
			line.each {|element| output += element.to_s}
			output += "\n"
		end
		puts output
	end

	#Sends the maze to the solver for solution, returns true if one exists, false otherwise
	def solve(begX, begY, endX, endY)
		@maze_solver.solve(begX, begY, endX, endY)
	end

	#Sends the maze to the solver for a solution, @maze_solver is modified to show solution after
	def trace(begX, begY, endX, endY)
		@maze_solver.trace(begX, begY, endX, endY)
	end

	#Resets maze, CHECK IF USED
	def reset_maze
		load(@maze_string)
	end

	#Redesigns the maze
	def redesign
		MazeDesigner.new(self).design
	end
end
