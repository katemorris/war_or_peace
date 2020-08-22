class Game
  attr_accessor :turn_count

  def stop_game?(player1, player2)
    player1.has_lost? == true || player2.has_lost? == true
  end

  def start
    @turn_count = 0
  end

end
