require './lib/display'

class Connect4

  include Display 

  attr_accessor \
    :game_over
  
  def initialize(player_1, player_2)
    @p1 = player_1
    @p2 = player_2
    @game_over = false
  end

  def play
    player = @p1

    until game_over
      show board
      
      position = prompt("#{player.name}: Choose a column")

      if position.match(/^[1-7]$/)
        puts position
        player == @p1 ? player = @p2 : player = @p1
      end 
    end 
  end
  
end