require_relative "maze_solver"
require_relative"nodes"

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
	end

	#Loads a string of 1s and 0s into the maze_array
	def load(arg)
		raise RuntimeError.new("Wrong size") if arg.size != @width*@height
		maze_format(arg)
		@maze_string.chars.each_index {|c| @maze_array[c / @width][c % @width] = @maze_string[c]}
		construct_node_array
		@maze_solver = MazeSolver.new(@maze_array)
	end

	def construct_node_array
		@maze_array.each_index{|j| @maze_array[j].each_index{|i| @maze_array[j][i] = Node.new(i, j) if i.odd? and j.odd?}}
		@maze_array.each_index do |j|
			j.each_index do |i|
				connect(@maze_array[j + 1][i], @maze_array[j - 1][i] if j.even? and @maze_array[j][i] == " "
				connect(@maze_array[j][i + 1], @maze_array[j][i - 1] if i.even? and @maze_array[j][i] == " ")
			end
		end
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
