class Game
  attr_accessor :turn_count

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
  end

  def stop_game?
    @player1.has_lost? || @player2.has_lost?
  end

  def game_winner
    if @player1.has_lost?
      puts "*~*~*~* #{@player2.name} has won the game! *~*~*~*"
    elsif @player2.has_lost?
      puts "*~*~*~* #{@player1.name} has won the game! *~*~*~*"
    else
      require "pry"; binding.pry
      pp "Something went wrong"
    end
  end

  def start
    @turn_count = 0
  end

end
