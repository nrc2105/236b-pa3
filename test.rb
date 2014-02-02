require_relative 'maze'

m = Maze.new(4,4)

m.load("111111111100010001111010101100010101101110101100000101111011101100000101111111111")

m.display

m.trace(0,0,3,3)

m.display

#.redesign

#m.display

#m = Maze.new(25, 25)

#input = "1" * (51* 51)

#m.load(input)

#m.redesign

#m.display

#puts m.solve(0,3, 21, 24)



