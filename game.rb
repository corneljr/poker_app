require_relative'ranker'
require_relative 'assets'

class Game
	attr_reader :player
	def initialize
		@dealer = Dealer.new
		@player = Player.new
	end
	def start_game
		@dealer.deal(@player)
	end
	def hand_value
		@player.hand
		Ranker.score(@player.hand)
	end
end

game = Game.new
game.start_game