require './lib/game'
game = Game.new
game.build_player_decks
game.add_players
# require "pry"; binding.pry
puts "Welcome to War! (or Peace) This game will be played with #{game.player1.deck.cards.count+game.player2.deck.cards.count} cards."
puts "The players today are #{game.player1.name} and #{game.player2.name}."
puts "Type 'GO' to start the game!"
ready = $stdin.gets.chomp

if ready.upcase == "GO"
  game.start
else
  p "You do not want to play my game? :( "
end
