require './lib/card'

class CardGenerator
  attr_reader :cards

  def initialize(filename)
    i = 1
    card_data = File.new(filename)
    @cards = card_data.readlines("\n", 52).map do |line|
      single_card = line.split(",")
      # require"pry"; binding.pry
      var_name = ("card" + i.to_s).to_sym
      i += 1
      var_name = Card.new(single_card[1].downcase.to_sym,single_card[0],single_card[2].strip.to_i)
    end
    card_data.close
  end

end
