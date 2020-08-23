require 'minitest/autorun'
require 'minitest/pride'
require './lib/card_generator'

class CardGeneratorTest < MiniTest::Test

  def test_run
    filename = "./lib/cards.txt"
    cards = CardGenerator.new(filename).cards
    p cards[0]
    assert_equal 52, cards.count
    assert_equal :heart, cards[0].suit
    assert_equal 3, cards[1].rank
  end

end
