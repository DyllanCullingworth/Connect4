module Display
  
  def show_board
    banner
    game_info

    (::Connect4::ROWS-1).downto(0) do |row|
      0.upto(::Connect4::COLUMNS-1) do |col| 
        print "| #{circle(@columns[col][row])} "
      end
      print "| \n"
    end

    puts <<~HEREDOC
      -----------------------------
      | 1 | 2 | 3 | 4 | 5 | 6 | 7 |


    HEREDOC
  end

  def show_winner(winner)
    show_board

    if winner
      puts "#{winner.name} is the winner"
    else
      puts "Game is a draw"
    end

    if play_again_prompt == 'Y'
      Connect4.new(@p1, @p2).play
    else
      puts "Thank you for playing!"
    end
  end

  def banner
    clear
    puts <<~HEREDOC
      |===========================|
      |======== CONNECT 4 ========|
      |===========================|

    HEREDOC
  end

  def game_info
    puts <<~HEREDOC
      | Player 1 #{circle(1)}  | Player 2 #{circle(2)}  |
      | #{display_name(@p1.name)}  | #{display_name(@p2.name)}  |
      | Score: #{display_score(@p1.score.to_s)}  | Score: #{display_score(@p2.score.to_s)}  |

    HEREDOC
  end

  def play_again_prompt
    prompt("Would you like to play again? [Y/N]").upcase
  end

  def prompt(message)
    puts message
    gets.chomp
  end

  def display_name(string)
    (string.length > 10) ? string.slice(0...10) : string.ljust(10, ' ')
  end

  def display_score(string)
    (string.length > 3) ? string.slice(0...3) : string.ljust(3, ' ')
  end

  def circle(value)
    circle = '\u25C9'.gsub(/\\u[\da-f]{4}/i) { |m| [m[-4..-1].to_i(16)].pack('U') }

    return circle.colorize(:red)    if value == 1 
    return circle.colorize(:yellow) if value == 2 
    circle.colorize(:white)
  end
  
  def clear
    print "\e[2J\e[H"
  end
end