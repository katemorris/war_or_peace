require './lib/card'

class CardGenerator
  attr_reader :cards

  def initialize(filename)
    card_data = File.new(filename)
    @cards = card_data.readlines("\n").map do |line|
      single_card = line.split(",")
      Card.new(single_card[1].downcase.to_sym,single_card[0],single_card[2].strip.to_i)
    end
    card_data.close
  end

end
