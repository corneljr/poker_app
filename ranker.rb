class Ranker

	def self.score(cards)
		if self.royal_flush?(cards)
			1_000_000_000
		elsif self.straight_flush?(cards)
			1_000
		elsif self.four_of_a_kind?(cards)
			900
		elsif self.full_house?(cards)
			800
		elsif self.flush?(cards)
			700
		elsif self.straight?(cards)
			600
		elsif self.three_of_a_kind?(cards)
			500
		elsif self.two_pair?(cards)
			400
		elsif self.pair?(cards)
			300
		else
			200
		end		
	end

	def self.royal_flush?(cards)
		Ranker.straight_flush?(cards) && Ranker.cards_in_numbers(cards).sort == [10,11,12,13,14]
	end

	def self.straight_flush?(cards)
		Ranker.straight?(cards) && Ranker.flush?(cards)
	end

	def self.straight?(cards)
		cards = Ranker.cards_in_numbers(cards)
		cards.uniq.length == 5 && (cards.max - cards.min)== 4
	end

	def self.flush?(cards)
		cards = Ranker.cards_in_suits(cards)
		cards.size - cards.uniq.size == 4
	end

	def self.four_of_a_kind?(cards)
		cards = Ranker.cards_in_numbers(cards)
		Ranker.card_counter(cards).values.include?(4)
	end

	def self.three_of_a_kind?(cards)
		cards = Ranker.cards_in_numbers(cards)
		cards.size - cards.uniq.size == 3
	end

	def self.pair?(cards)
		cards = Ranker.cards_in_numbers(cards)
		hash = card_counter(cards)
		hash.values.include?(2)
	end

	def self.highest_card?(cards)
		Ranker.cards_in_numbers(cards).max
	end

	def self.full_house?(cards)
		cards = Ranker.cards_in_numbers(cards)
		hash = card_counter(cards)
		hash.values.include?(2) && hash.values.include?(3)
	end

	def self.two_pair?(cards)
		cards = Ranker.cards_in_numbers(cards)
		hash = card_counter(cards)
		hash.values.include?(2) && hash.length == 3 
	end

	def self.tie_breaker(player,computer)
		player_hand = Ranker.cards_in_numbers(player)
		computer_hand = Ranker.cards_in_numbers(computer)

		comparison = player_hand.max <=> computer_hand.max
		case comparison
		when 1 then "win"
		when -1 then "loss"
		else player_hand.sort[-2] > computer_hand.sort[-2] ? "win" : "loss"
		end
	end

	def self.cards_in_suits(cards)
		 cards.map(&:suit)
	end

	def self.cards_in_numbers(cards)
		 cards.map(&:number)
	end

	def self.card_counter(cards)
		hash = Hash.new(0)
			cards.each do |card|
				hash[card] += 1
		end
		hash
	end

	def self.display_hand(hand)
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

	def self.outcome(player, computer)
		outcome = Ranker.score(player) <=> Ranker.score(computer)
		case outcome
		when -1 then winner = "loss"
		when 0 then winner = Ranker.tie_breaker(player,computer)
		when 1 then winner = "win"
		end
		winner
	end
end