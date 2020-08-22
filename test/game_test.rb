require 'minitest/autorun'
require 'minitest/pride'
require './lib/card'
require './lib/deck'
require './lib/player'
require './lib/turn'
require './lib/game'

class GameTest < Minitest::Test

  def test_initialize
    game = Game.new

    assert_equal 0, game.turn_count
    assert_instance_of Turn, @turn
    assert_equal 26, @player1.deck.cards.count
    assert_equal 26, @player2.deck.cards.count
  end

  def test_initial_deck
    game = Game.new

    assert_instance_of Deck, game.card_deck
    assert_equal 52, game.card_deck.cards.count
  end

  def test_building_decks
    game = Game.new

    assert_equal 26, @deck1.cards.count
    assert_equal 26, @deck2.cards.count

    game2 = Game.new

    refute_equal game2.deck1, game.deck1
    refute_equal game2.deck2, game.deck2
  end

  def test_start
    game = Game.new
    game.start
  end

  def test_turn_loop

  end

  def test_stop_game
    game = Game.new
    game.start

    assert_equal false, game.stop_game?

    4.times { player1.deck.remove_card }
    assert_equal 0, player1.deck.cards.count

    assert_equal true, game.stop_game?
  end

  def test_game_winner

    game = Game.new
    game.start
  end

end
