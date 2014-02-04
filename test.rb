require_relative 'maze'

separate = "*" * 100

m = Maze.new(4,4)

m.load("111111111100010001111010101100010101101110101100000101111011101100000101111111111")
puts separate
puts "Original Maze"

m.display

puts separate
puts "Traced Maze"

m.trace(0,0,3,3)

m.display

puts separate
puts "Redesigned"

m.redesign

m.display

puts separate
puts "Traced"

m.trace(0,0,3,3)

m.display

puts separate
puts "Bigger Maze"

m = Maze.new(25, 25)

input = "1" * (51 * 51)

m.load(input)

m.display

puts separate
puts "Redesigned and Traced"
m.redesign

m.trace(0,0,24,24)

m.display




