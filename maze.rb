require_relative "maze_solver"

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
		@maze_solver = MazeSolver.new(@width, @height, @maze_array)
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

	def redesign
		@maze_string = construct_default_maze_string
		temp_maze = "1" * @maze_string.size
		temp_maze.chars.each_index do |c|
			if c > @width and c < temp_maze.size - @width and c % @width > 0 and c % @width < @width - 1 and ((c / @width % 2 == 0 and c % @width % 2 != 0) ^ (c / @width % 2 != 0 and c % @width % 2 ==0))
				temp_maze[c] = rand(2).to_s
			end
		end
		load(temp_maze)
	end
end
