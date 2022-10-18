require './lib/player'
require './lib/connect4'
require 'colorize'

# p1 = Player.new(1)
# p2 = Player.new(2)
p1 = Player.new(1, name: 'Dyllan')
p2 = Player.new(2, name: 'John')
game = Connect4.new(p1, p2).play