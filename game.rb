require_relative'ranker'
require_relative 'assets'
require_relative 'rolodex'

class Game
	attr_reader :player1, :player2
	def initialize
		@dealer = Dealer.new
		@player1 = Player.new
		@player2 = Player.new
	end
	def start_game
		@dealer.deal(@player1,@player2)
	end
	def hand_value
		outcome = Ranker.score(@player1.hand) <=> Ranker.score(@player2.hand)
		case outcome
		when -1 then "Player 2 Wins"
		when 0 then "Tie"
		when 1 then "Player 1 Wins!"
		end
	end
end
