class Turn
  attr_reader :player1, :player2, :spoils_of_war

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @spoils_of_war = []
  end

  def type
    if @player1.deck.rank_of_card_at(0) == @player2.deck.rank_of_card_at(0) && @player1.deck.rank_of_card_at(2) == @player2.deck.rank_of_card_at(2)
      return :mutually_assured_destruction
    elsif @player1.deck.rank_of_card_at(0) != @player2.deck.rank_of_card_at(0)
      return :basic
    else
      return :war
    end
  end

  def winner
    if self.type == :basic
      return @player1 if @player1.deck.rank_of_card_at(0) > @player2.deck.rank_of_card_at(0)
      return @player2 if @player1.deck.rank_of_card_at(0) < @player2.deck.rank_of_card_at(0)
    elsif self.type == :war
      return @player1 if @player1.deck.rank_of_card_at(2) > @player2.deck.rank_of_card_at(2)
      return @player2 if @player1.deck.rank_of_card_at(2) < @player2.deck.rank_of_card_at(2)
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
