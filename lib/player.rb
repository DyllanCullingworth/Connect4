require './lib/display'

class Player

  include Display
  
  attr_accessor \
    :player_number,
    :name, 
    :score
  
  @@other_game_piece = ""

  def initialize(player_number, name: set_player_name(player_number))
    @player_number = player_number
    @name          = name
    @score         = 0
  end

  def set_player_name(player_number)
    banner
    prompt("Player #{player_number}: What is your name?")
  end

end