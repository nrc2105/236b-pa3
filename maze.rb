require_relative "maze_solver"

class Maze

	attr_reader :maze_solver, :maze_array
	#Initializes the maze with size allowing for walls around all 'chambers'
	def initialize (n,m)
		@width = n*2 + 1
		@height = m*2 + 1
		@maze_array = Array.new(@height){Array.new(@width){0}}
	end

	#Loads a string of 1s and 0s into the maze_array
	def load(arg)
		raise RuntimeError.new("Wrong size") if arg.size != @width*@height
		arg.chars.each_index {|c| @maze_array[c / @width][c % @width] = arg[c]}
		@maze_solver = MazeSolver.new(@width, @height, @maze_array)
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
end
