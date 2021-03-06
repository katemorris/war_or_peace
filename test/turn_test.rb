require 'minitest/autorun'
require 'minitest/pride'
require './lib/card'
require './lib/deck'
require './lib/player'
require './lib/turn'

class TurnTest < Minitest::Test

  def setup
    @card1 = Card.new(:heart, 'Jack', 11)
    @card2 = Card.new(:heart, '10', 10)
    @card3 = Card.new(:heart, '9', 9)
    @card4 = Card.new(:diamond, 'Jack', 11)
    @card5 = Card.new(:heart, '8', 8)
    @card6 = Card.new(:diamond, 'Queen', 12)
    @card7 = Card.new(:heart, '3', 3)
    @card8 = Card.new(:diamond, '2', 2)
    @deck1 = Deck.new([@card1, @card2, @card5, @card8])
    @deck2 = Deck.new([@card3, @card4, @card6, @card7])
    @player1 = Player.new("Megan", @deck1)
    @player2 = Player.new("Aurora", @deck2)
    @turn = Turn.new(@player1, @player2)
  end

  def test_it_exists
    assert_instance_of Turn, @turn
    assert_equal "Aurora", @turn.player2.name
    assert_equal [], @turn.spoils_of_war
  end

  def test_running_turn
    assert_equal :basic, @turn.type
    winner = @turn.winner
    assert_equal "Megan", winner.name

  end

  def test_after_winning_effects
    winner = @turn.winner

    assert_equal [], @turn.spoils_of_war

    @turn.pile_cards

    refute_equal [], @turn.spoils_of_war

    @turn.award_spoils(winner)

    assert_equal 5, @player1.deck.cards.count
    assert_equal 3, @player2.deck.cards.count
  end

  def test_war_simulation
    card1 = Card.new(:heart, 'Jack', 11)
    card2 = Card.new(:heart, '10', 10)
    card3 = Card.new(:heart, '9', 9)
    card4 = Card.new(:diamond, 'Jack', 11)
    card5 = Card.new(:heart, '8', 8)
    card6 = Card.new(:diamond, 'Queen', 12)
    card7 = Card.new(:heart, '3', 3)
    card8 = Card.new(:diamond, '2', 2)

    deck1 = Deck.new([card1, card2, card5, card8])
    deck2 = Deck.new([card4, card3, card6, card7])

    player1 = Player.new("Megan", deck1)
    player2 = Player.new("Aurora", deck2)

    turn = Turn.new(player1, player2)

    assert_equal :war, turn.type
    winner = turn.winner
    assert_equal "Aurora", winner.name

    assert_equal [], turn.spoils_of_war
    turn.pile_cards
    assert_equal [card1, card4, card2, card3, card5, card6], turn.spoils_of_war

    turn.award_spoils(winner)

    assert_equal 1, player1.deck.cards.count
    assert_equal 7, player2.deck.cards.count
  end

  def test_mutually_assured_destruction
    card1 = Card.new(:heart, 'Jack', 11)
    card2 = Card.new(:heart, '10', 10)
    card3 = Card.new(:heart, '9', 9)
    card4 = Card.new(:diamond, 'Jack', 11)
    card5 = Card.new(:heart, '8', 8)
    card6 = Card.new(:diamond, '8', 8)
    card7 = Card.new(:heart, '3', 3)
    card8 = Card.new(:diamond, '2', 2)

    deck1 = Deck.new([card1, card2, card5, card8])
    deck2 = Deck.new([card4, card3, card6, card7])

    player1 = Player.new("Megan", deck1)
    player2 = Player.new("Aurora", deck2)

    turn = Turn.new(player1, player2)

    assert_equal :mutually_assured_destruction, turn.type
    winner = turn.winner
    assert_equal "No Winner", winner

    assert_equal [], turn.spoils_of_war
    turn.pile_cards
    assert_equal [], turn.spoils_of_war

    assert_equal [card8], player1.deck.cards
    assert_equal [card7], player2.deck.cards

  end

  def test_lack_of_cards_one_card_each
    card1 = Card.new(:heart, 'Jack', 11)
    card2 = Card.new(:heart, '10', 10)
    card3 = Card.new(:heart, '9', 9)
    card4 = Card.new(:diamond, 'Jack', 11)
    card5 = Card.new(:heart, '8', 8)
    card6 = Card.new(:diamond, '8', 8)
    card7 = Card.new(:heart, '3', 3)
    card8 = Card.new(:diamond, '3', 3)

    deck1 = Deck.new([card1, card2, card5, card8])
    deck2 = Deck.new([card4, card3, card6, card7])

    player1 = Player.new("Megan", deck1)
    player2 = Player.new("Aurora", deck2)

    turn = Turn.new(player1, player2)
    turn.pile_cards
    assert_equal [], turn.spoils_of_war

    turn2 = Turn.new(player1, player2)

    assert_equal [card8], player1.deck.cards
    assert_equal [card7], player2.deck.cards
    assert_equal :no_cards, turn.type

    winner = turn2.winner
    assert_equal "No Winner", turn.winner

    turn2.pile_cards

    assert_equal "It's a DRAW!", turn2.pile_cards
    turn2.award_spoils(winner)
  end

  def test_lack_of_cards_lopsided
    card1 = Card.new(:heart, 'Jack', 11)
    card2 = Card.new(:heart, '10', 10)
    card3 = Card.new(:heart, '9', 9)
    card4 = Card.new(:diamond, 'Jack', 11)
    card5 = Card.new(:heart, '8', 8)
    card6 = Card.new(:diamond, '8', 8)
    card7 = Card.new(:heart, '3', 3)
    card8 = Card.new(:diamond, '3', 3)

    deck1 = Deck.new([card1, card2, card5, card8, card3, card6, card7])
    deck2 = Deck.new([card4])

    player1 = Player.new("Megan", deck1)
    player2 = Player.new("Aurora", deck2)

    turn = Turn.new(player1, player2)
    winner = turn.winner

    assert_equal "No Winner", turn.winner
    assert_equal :no_cards, turn.type

    turn.pile_cards

    assert_equal [], turn.spoils_of_war
    assert_equal [], player2.deck.cards
    assert_equal "No cards to award!", turn.award_spoils(winner)
  end
end
