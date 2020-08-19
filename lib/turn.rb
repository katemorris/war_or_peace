class Turn
  attr_reader :player1, :player2, :spoils_of_war

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @spoils_of_war = []
  end

  def type
    player1_card1 = @player1.deck.rank_of_card_at(0)
    player2_card1 = @player2.deck.rank_of_card_at(0)
    player1_card3 = @player1.deck.rank_of_card_at(2)
    player2_card3 = @player2.deck.rank_of_card_at(2)
    if player1_card1 == player2_card1 && player1_card3 == player2_card3
      return :mutually_assured_destruction
    elsif player1_card1 != player2_card1
      return :basic
    else
      return :war
    end
  end

  def winner
    if self.type == :basic
      if @player1.deck.rank_of_card_at(0) > @player2.deck.rank_of_card_at(0)
        return @player1
      else
        return @player2
      end
    elsif self.type == :war
      if @player1.deck.rank_of_card_at(2) > @player2.deck.rank_of_card_at(2)
        return @player1
      else
        return @player2
      end
    else
      return "No Winner"
    end
  end

  def pile_cards
    if self.type == :basic
      @spoils_of_war << player1.deck.cards.shift
      @spoils_of_war << player2.deck.cards.shift
    elsif self.type == :war
      @spoils_of_war << player1.deck.cards.shift(3)
      @spoils_of_war << player2.deck.cards.shift(3)
    else
      player1.deck.cards.shift(3)
      player2.deck.cards.shift(3)
    end
  end

  def award_spoils(winner)
    @spoils_of_war.each do |card|
      winner.deck.cards << card
    end
  end
end
