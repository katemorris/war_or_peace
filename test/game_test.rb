require 'minitest/autorun'
require 'minitest/pride'
require 'stringio'
require './lib/card'
require './lib/deck'
require './lib/player'
require './lib/turn'
require './lib/game'

class GameTest < Minitest::Test

  def test_new_game
    game = Game.new

    assert_equal 0, game.turn_count
  end

  def test_initial_static_deck
    game = Game.new
    game.make_card_deck

    assert_instance_of Deck, game.card_deck
    assert_equal 52, game.card_deck.cards.count
  end

  def test_building_decks_not_same
    game = Game.new
    game.build_player_decks

    assert_equal 26, game.deck1.cards.count
    assert_equal 26, game.deck2.cards.count

    game2 = Game.new
    game2.build_player_decks

    refute_equal game2.deck1.cards, game.deck1.cards
    refute_equal game2.deck2.cards, game.deck2.cards
  end

  def test_add_players
    game = Game.new
    @deck1 = Deck.new([])
    @deck2 = Deck.new([])
    game.add_players

    assert_equal 2, game.players.count
    assert_equal "Kate", game.player1.name
    assert_nil game.player2.deck
  end

  def test_start_million_turn_draw
    game = Game.new
    game.turn_count = 1000000
    assert_equal "---- DRAW ----", game.start
  end

  def test_turn_basic
    game = Game.new

    card1 = Card.new(:heart, 'Jack', 11)
    card2 = Card.new(:heart, '10', 10)
    card3 = Card.new(:heart, '9', 9)
    card4 = Card.new(:diamond, 'Jack', 11)
    card5 = Card.new(:heart, '8', 8)
    card6 = Card.new(:diamond, 'Queen', 12)
    card7 = Card.new(:heart, '3', 3)
    card8 = Card.new(:diamond, '2', 2)
    game.deck1 = Deck.new([card1, card2, card5, card8])
    game.deck2 = Deck.new([card3, card4, card6, card7])
    game.player1 = Player.new("Megan", game.deck1)
    game.player2 = Player.new("Aurora", game.deck2)
    game.turn = Turn.new(game.player1, game.player2)

    assert_equal "Megan", game.turn.winner.name
    assert_equal "Turn 1: Megan won 2 cards.", game.go_turn
    assert_equal 1, game.turn_count
    assert_equal :basic, game.turn.type
  end

  def test_turn_war
    game = Game.new

    card1 = Card.new(:heart, 'Jack', 11)
    card2 = Card.new(:heart, '10', 10)
    card3 = Card.new(:heart, '9', 9)
    card4 = Card.new(:diamond, 'Jack', 11)
    card5 = Card.new(:heart, '8', 8)
    card6 = Card.new(:diamond, 'Queen', 12)
    card7 = Card.new(:heart, '3', 3)
    card8 = Card.new(:diamond, '2', 2)
    game.deck1 = Deck.new([card1, card2, card5, card8])
    game.deck2 = Deck.new([card4, card3, card6, card7])
    game.player1 = Player.new("Megan", game.deck1)
    game.player2 = Player.new("Aurora", game.deck2)
    game.turn = Turn.new(game.player1, game.player2)

    assert_equal "Aurora", game.turn.winner.name
    assert_equal :war, game.turn.type
    assert_equal "Turn 1: WAR - Aurora won 6 cards.", game.go_turn
    assert_equal 1, game.turn_count

  end

  def test_turn_mad
    game = Game.new

    card1 = Card.new(:heart, 'Jack', 11)
    card2 = Card.new(:heart, '10', 10)
    card3 = Card.new(:heart, '9', 9)
    card4 = Card.new(:diamond, 'Jack', 11)
    card5 = Card.new(:heart, 'Queen', 12)
    card6 = Card.new(:diamond, 'Queen', 12)
    card7 = Card.new(:heart, '3', 3)
    card8 = Card.new(:diamond, '2', 2)
    game.deck1 = Deck.new([card1, card2, card5, card8])
    game.deck2 = Deck.new([card4, card3, card6, card7])
    game.player1 = Player.new("Megan", game.deck1)
    game.player2 = Player.new("Aurora", game.deck2)
    game.turn = Turn.new(game.player1, game.player2)

    assert_equal "No Winner", game.turn.winner
    assert_equal :mutually_assured_destruction, game.turn.type
    assert_equal "Turn 1: *mutually assured destruction* 6 cards removed from play", game.go_turn
    assert_equal 1, game.turn_count
  end

  def test_turn_no_cards
    game = Game.new

    card1 = Card.new(:heart, 'Jack', 11)
    card2 = Card.new(:heart, '10', 10)
    card3 = Card.new(:heart, '9', 9)
    game.deck1 = Deck.new([card1, card2])
    game.deck2 = Deck.new([card3])
    game.player1 = Player.new("Megan", game.deck1)
    game.player2 = Player.new("Aurora", game.deck2)
    game.turn = Turn.new(game.player1, game.player2)

    assert_equal "Megan", game.turn.winner.name
    assert_equal :basic, game.turn.type
    assert_equal "Turn 1: Megan won 2 cards.", game.go_turn
    # Next turn tests what happens when a player has no cards.
    assert_equal "*~*~*~* Megan has won the game! *~*~*~*", game.go_turn

  end

  def test_turn_not_enough_cards
    game = Game.new

    card1 = Card.new(:heart, 'Jack', 11)
    card2 = Card.new(:heart, '10', 10)
    card3 = Card.new(:spade, 'Jack', 11)
    game.deck1 = Deck.new([card1, card2])
    game.deck2 = Deck.new([card3])
    game.player1 = Player.new("Megan", game.deck1)
    game.player2 = Player.new("Aurora", game.deck2)
    game.turn = Turn.new(game.player1, game.player2)

    assert_equal "No Winner", game.turn.winner
    assert_equal :no_cards, game.turn.type
    assert_equal "No more cards!", game.go_turn
    # Next turn checks winner
    assert_equal "*~*~*~* Megan has won the game! *~*~*~*", game.go_turn
  end

end
