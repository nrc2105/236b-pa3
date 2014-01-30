class Maze

	def initialize (n,m)
		@width = n
		@height = m
		@maze_array = Array.new(@height){Array.new(@width){0}}
	end

	def load(arg)
		raise RuntimeError.new("Wrong size") if arg.size != @width*@height
		return arg.chars.each_index {|c| @maze_array[c / @width][c % @width] = arg[c]}
	end


	def display
		output = ""
		@maze_array.each do |line|
			line.each {|element| output += element}
			output += "\n"
		end
		puts output
	end
end
