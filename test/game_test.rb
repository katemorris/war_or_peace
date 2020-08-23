require 'minitest/autorun'
require 'minitest/pride'
require 'stringio'
require './lib/card'
require './lib/deck'
require './lib/player'
require './lib/turn'
require './lib/game'

class GameTest < Minitest::Test

  def test_initialize
    game = Game.new

    assert_equal 0, game.turn_count
  end

  def test_initial_deck
    game = Game.new
    game.make_card_deck

    assert_instance_of Deck, game.card_deck
    assert_equal 52, game.card_deck.cards.count
  end

  def test_building_decks
    game = Game.new

    assert_equal 26, game.deck1.cards.count
    assert_equal 26, game.deck2.cards.count

    game2 = Game.new

    refute_equal game2.deck1.cards, game.deck1.cards
    refute_equal game2.deck2.cards, game.deck2.cards
  end

  def test_start
    game = Game.new

    string_io = StringIO.new
    string_io.puts 'No'
    string_io.rewind
    $stdin = string_io

    assert_equal "You do not want to play my game? :( ", game.start

    assert_equal "Kate", game.player1.name
    assert_equal 26, game.player1.deck.cards.count
    assert_equal 26, game.player2.deck.cards.count
    $stdin = STDIN
  end

  def test_turn_loop
    game = Game.new
    string_io = StringIO.new
    string_io.puts 'Go'
    string_io.rewind
    $stdin = string_io
    game.start
    $stdin = STDIN

    refute_nil game.cards_removed
    assert game.game_end.include?("Won")
  end

  def test_stop_game
    game = Game.new
    game.turn_count = 999999
    string_io = StringIO.new
    string_io.puts 'No'
    string_io.rewind
    $stdin = string_io
    game.start


    $stdin = STDIN

    assert_nil game.stop_game_check

    game.player1.deck.cards.count.times { game.player1.deck.remove_card }

    assert_equal 0, game.player1.deck.cards.count
    assert_equal true, game.player1.has_lost?
    assert_equal "*~*~*~* Caryn has won the game! *~*~*~*", game.stop_game_check

  end

end
