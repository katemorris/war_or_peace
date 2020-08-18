class Card
  attr_reader :rank, :suit, :value
  attr_accessor :cards

  def initialize(suit, value, rank)
    @rank = rank
    @suit = suit
    @value = value
    @cards = []
    @cards << self
  end

end
