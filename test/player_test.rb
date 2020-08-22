require 'minitest/autorun'
require 'minitest/pride'
require './lib/card'
require './lib/deck'
require './lib/player'

class PlayerTest < Minitest::Test
  def setup
    @card1 = Card.new(:diamond, 'Queen', 12)
    @card2 = Card.new(:spade, '3', 3)
    @card3 = Card.new(:heart, 'Ace', 14)
    @deck = Deck.new([@card1, @card2, @card3])
    @player = Player.new('Clarisa', @deck)

    assert_instance_of Player, @player
  end

  def test_attributes
    assert_equal 'Clarisa', @player.name
    assert_equal @deck, @player.deck
  end

  def test_player_loses_at_empty
    refute @player.has_lost?
    @player.deck.remove_card
    refute @player.has_lost?
    @player.deck.remove_card
    refute @player.has_lost?
    @player.deck.remove_card
    assert @player.has_lost?

    assert_equal [], @player.deck.cards
  end
end
