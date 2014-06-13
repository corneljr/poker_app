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
	def display_hand(hand)
		hand_score = Ranker.score(hand)
		hand_str = ""
		case hand_score
			when 1_000_000_000 then hand_str = "Royal Flush"
			when 1_000 then hand_str = "Straight Flush"
			when 900 then hand_str = "Four of a Kind"
			when 800 then hand_str = "Full House"
			when 700 then hand_str = "Flush"
			when 600 then hand_str = "Straight"
			when 500 then hand_str = "Three of a Kind"
			when 400 then hand_str = "Two Pair"
			when 300 then hand_str = "Pair"
			when 200 then hand_str = "High Card"
		end
		hand_str
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
