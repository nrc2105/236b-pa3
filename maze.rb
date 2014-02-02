require_relative "maze_solver"
require_relative"node"

class Maze

	attr_reader :maze_solver, :maze_array
	#Initializes the maze with size allowing for walls around all 'chambers'
	def initialize (n,m)
		@cell_width = n
		@cell_height = m
		@width = n*2 + 1
		@height = m*2 + 1
		@maze_array = Array.new(@height){Array.new(@width){0}}
		@maze_string = construct_default_maze_string
		@nodes = Array.new(@cell_height){Array.new(@cell_width)}
	end

	#Loads a string of 1s and 0s into the maze_array
	def load(arg)
		raise RuntimeError.new("Wrong size") if arg.size != @width*@height
		maze_format(arg)
		@maze_string.chars.each_index {|c| @maze_array[c / @width][c % @width] = @maze_string[c]}
		construct_node_array
		@maze_solver = MazeSolver.new(@nodes, @maze_array)
	end

	def construct_node_array
		@nodes.each_index{|j| @nodes[j].each_index{|i| @nodes[j][i] = Node.new(i, j)}}
		@maze_array.each_index do |j|
			@maze_array[j].each_index do |i|
				connect(@nodes[j / 2][(i-1)/2], @nodes[j / 2 - 1][(i-1)/2]) if j.even? and i.odd? and @maze_array[j][i] == " "
				connect(@nodes[(j-1)/2][i / 2], @nodes[(j-1)/2][i / 2 - 1]) if i.even? and j.odd? and @maze_array[j][i] == " "
			end
		end
	end

	def connect(node1, node2)
		node1.add_adjacent(node2)
		node2.add_adjacent(node1)
	end

	def construct_default_maze_string
		top = "+-" * @cell_width + "+"
		body = "|" + (" |" * @cell_width)
		top + (body + top) * @cell_height
	end

	def maze_format(arg)
		arg.chars.each_index {|c| @maze_string[c] = " " if arg[c] == "0"}
	end

	#Displays the maze
	def display
		output = ""
		@maze_array.each do |line|
			line.each {|element| output += element}
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

	def reset_maze
		load(@maze_string)
	end

end
