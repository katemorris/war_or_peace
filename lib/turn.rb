class Turn
  attr_reader :player1, :player2, :spoils_of_war, :players

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @players = [@player1, @player2]
    @spoils_of_war = []
  end

  def type
    player1_card1 = @player1.deck.rank_of_card_at(0)
    player2_card1 = @player2.deck.rank_of_card_at(0)
    if @players.all? {|player| player.deck.cards.count >= 3}
      player1_card3 = @player1.deck.rank_of_card_at(2)
      player2_card3 = @player2.deck.rank_of_card_at(2)
      if player1_card1 == player2_card1 && player1_card3 == player2_card3
        return :mutually_assured_destruction
      elsif player1_card1 != player2_card1
        return :basic
      else
        return :war
      end
    elsif @players.all? {|player| player.deck.cards.count >= 1}
      if player1_card1 != player2_card1
        return :basic
      else
        return :no_cards
      end
    else
      return :no_cards
    end
  end

  def winner
    if self.type == :basic
      @players.max_by do |player|
        player.deck.rank_of_card_at(0)
      end
    elsif self.type == :war
      @players.max_by do |player|
        player.deck.rank_of_card_at(2)
      end
    else
      return "No Winner"
    end
  end

  def pile_cards
    if self.type == :basic
      @spoils_of_war.push(@player1.deck.remove_card, @player2.deck.remove_card)
    elsif self.type == :war
      3.times do
        @spoils_of_war.push(@player1.deck.remove_card, @player2.deck.remove_card)
      end
    elsif self.type == :mutually_assured_destruction
      3.times do
        @player1.deck.remove_card
        @player2.deck.remove_card
      end
    else
    require "pry"; binding.pry
      lowest_player = @players.min_by do |player|
        player.deck.cards.count
      end
      lowest_player.deck.remove_card until lowest_player.deck.cards.count == 0
      #remove cards from lowest deck player until they get to zero
      # add test for this!
      # This is a draw in my test! What happens if the last cards are equal?
    end
  end

  def award_spoils(winner)
    if winner == "No Winner"
      puts "No cards to award!"
    else
      @spoils_of_war.each do |card|
        winner.deck.cards << card
      end
    end
  end
end
