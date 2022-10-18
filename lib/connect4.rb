require './lib/display'

class Connect4

  include Display 

  attr_accessor \
    :columns,
    :winner

  COLUMNS = 7
  ROWS    = 6
  
  def initialize(player_1, player_2)
    @p1             = player_1
    @p2             = player_2
    @winner         = nil
    @columns        = COLUMNS.times.map { [0,0,0,0,0,0] }
  end

  def play
    player = @p1

    loop do
      show_board

      position = prompt("#{player.name}: Choose a column")

      if position.match(/^[1-7]$/) 
        column = @columns[position.to_i - 1]
        
        if column.include?(0)
          column[column.find_index(0)] = player.player_number
          
          if player_wins?(player)
            player.score += 1
            winner = player
            break 
          end

          if stalemate?
            break
          end
          
          player == @p1 ? player = @p2 : player = @p1
        end
      end 
    end 

    show_winner
  end

  def stalemate?
    !@columns.flatten.include?(0)
  end

  def player_wins?(player)
    player_number = player.player_number
    
    0.upto(COLUMNS-1) do |col|
      0.upto(ROWS-1) do |row|
        if @columns[col][row] == player_number
          return true if check_fields(col, row, player_number).any?
        end
      end
    end
    
    false
  end

  def check_fields(col, row, player_number)
    [
      up(col, row, player_number), 
      up_right(col, row, player_number),
      right(col, row, player_number),
      down_right(col, row, player_number)
    ]
  end

  def up(col, row, player_number)
    return false if row+3 > ROWS-1
    [
      @columns[col][row],
      @columns[col][row+1],
      @columns[col][row+2],
      @columns[col][row+3]
    ].map {|item| item == player_number }.all?
  end

  def up_right(col, row, player_number)
    return false if col+3 > COLUMNS-1 || row+3 > ROWS-1
    [
      @columns[col][row],
      @columns[col+1][row+1],
      @columns[col+2][row+2],
      @columns[col+3][row+3]
    ].map {|item| item == player_number }.all?
  end

  def right(col, row, player_number)
    return false if col+3 > COLUMNS-1
    [
      @columns[col][row],
      @columns[col+1][row],
      @columns[col+2][row],
      @columns[col+3][row]
    ].map {|item| item == player_number }.all?
  end

  def down_right(col, row, player_number)
    return false if col+3 > COLUMNS-1 || row-3 < 0
    [
      @columns[col][row],
      @columns[col+1][row-1],
      @columns[col+2][row-2],
      @columns[col+3][row-3]
    ].map {|item| item == player_number }.all?
  end

  
end