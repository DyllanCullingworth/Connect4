module Display

  # def show_board
  #   clear
    
  #   row1 =   " #{@board_positions[0]} | #{@board_positions[1]} | #{@board_positions[2]} "
  #   row2 =   " #{@board_positions[3]} | #{@board_positions[4]} | #{@board_positions[5]} "
  #   row3 =   " #{@board_positions[6]} | #{@board_positions[7]} | #{@board_positions[8]} "
  #   divider ="---+---+---"
    
  #   puts <<~HEREDOC
  #     |=============================|
  #     |========= CONNECT 4 =========|
  #     |=============================|

  #     #{row1}   | #{@p1.game_piece}: #{@p1.score}  (#{@p1.name})
  #     #{divider}   | #{@p2.game_piece}: #{@p2.score}  (#{@p2.name})
  #     #{row2}   *----------------
  #     #{divider}
  #     #{row3}

  #   HEREDOC
  # end

  def banner
    clear
    puts <<~HEREDOC
      |=============================|
      |========= CONNECT 4 =========|
      |=============================|

    HEREDOC
  end

  def prompt(message)
    puts message
    gets.chomp
  end
  
  def clear
    print "\e[2J\e[H"
  end
end