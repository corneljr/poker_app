require_relative 'ranker'
require_relative 'assets'

class Game
	attr_reader :player, :computer, :result
	def initialize(rolodex)
		@rolodex = rolodex
		@dealer = Dealer.new
		@player = Player.new
		@computer = Player.new
	end
	def start_game
		@dealer.deal(@player,@computer)
	end
	def hand_value
		outcome = Ranker.score(@player.hand) <=> Ranker.score(@computer.hand)
		case outcome
		when -1 then winner = "computer"
		when 0 then winner = Ranker.tie_breaker(@player.hand,@computer.hand)
		when 1 then winner = "player"
		end
	end
end

class Rolodex 
	attr_accessor :name,:record

	def initialize
		@record = Hash.new(0)
	end

	def update_record(winner)
		@record[winner] += 1
	end
end
