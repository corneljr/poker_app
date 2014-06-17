class Card
	attr_reader :suit, :number
	def initialize(suit, number)
		@suit = suit
		@number = number
	end

	def self.parse_card(number)
	  case number
		when 2..10 then number
		when 11 then "J"
		when 12 then "Q"
		when 13 then "K"
		when 14 then "A"
		end
	end

end

class Deck
	SUITS = ["&#9830;", "&#9827;", "&#9829;", "&#9824;"]
	NUMBERS = (2..14).to_a
	attr_accessor :deck 
	def initialize
		@deck = []
		SUITS.each do |suit|
			NUMBERS.each do |num|
				@deck << Card.new(suit, num)
			end
		end
	end
end

class Dealer

	def initialize
		@deck = Deck.new
	end

	def deal(player1,player2)
		deck = @deck.deck.shuffle!
		to_deal = deck.pop(10)
		player1.hand = to_deal[5..9]
		player2.hand = to_deal[0..4]
	end
	
end

class Player
	attr_accessor :hand
	def initialize
		@hand = []
	end
	
end