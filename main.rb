require './lib/player'
require './lib/connect4'

p1 = Player.new(1)
p2 = Player.new(2)
game = Connect4.new(p1, p2).play