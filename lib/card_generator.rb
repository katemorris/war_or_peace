require './lib/card'

class CardGenerator
  attr_reader :cards

  def initialize(filename)
    card_data = open(filename)
    @cards = File.readlines(filename)
    @cards.map do |line|
      Card.new(line[0],":"+line.downcase[1],line[2])
    end
    card_data.close
  end

end
