class Game
  attr_accessor :turn_count

  def initialize
    @turn_count = 0
  end


  def start(player1, player2)
    if turn_count < 1000000 && self.stop_game == false
      turn = Turn.new(player1, player2)
      turn_count += 1
      if self.turn.type == :basic
        puts "Turn #{turn_count}: #{self.turn.winner} won 2 cards."
        self.turn.pile_cards
        self.turn.award_spoils(self.turn.winner)
      elsif self.turn.type == :war
        puts "Turn #{turn_count}: WAR - #{self.turn.winner} won 6 cards."
        self.turn.pile_cards
        self.turn.award_spoils(self.turn.winner)
      else
        puts "Turn #{turn_count}: *mutually assured destruction* 6 cards removed from play"
      end
    elsif self.stop_game == true
      if player1.has_lost? == true
        puts "*~*~*~* #{player2.name has won the game!} *~*~*~*"
      else
        puts "*~*~*~* #{player1.name has won the game!} *~*~*~*"
      end
    else
      puts "---- DRAW ----"
      exit(0)
    end
  end

  def stop_game
    player1.has_lost? == true || player2.has_lost? == true
  end
end
