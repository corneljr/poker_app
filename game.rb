require_relative 'ranker'
require_relative 'assets'
require_relative 'rolodex'

class Game
	attr_reader :player1, :player2, :record
	def initialize(rolodex)
		@rolodex = rolodex
		@record = Hash.new(0)
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
		when -1 then @rolodex.update_record("player2"); "Player 2 Wins"
		when 0 then tie(@player1.hand,@player2.hand)
		when 1 then @rolodex.update_record("player1"); "Player 1 Wins!"
		end
	end

	def tie(hand1,hand2)
		hand1 = Ranker.cards_in_numbers(hand1)
		hand2 = Ranker.cards_in_numbers(hand2)

		# while hand1.length > 2
		comparison = hand1.max <=> hand2.max
		case comparison
		when 1 then @rolodex.update_record("player1"); "player 1 wins!"
		when -1 then @rolodex.update_record("player2"); "player 2 wins"
		else "tie"
			# hand1 = hand1.delete(hand1.max)
			# hand2 = hand2.delete(hand2.max)
		end
	end
end
