class Rolodex 
	attr_accessor :name,:record
	
	def initialize
		@record = 0
	end

	def update_record(winner)
		@record[winner] += 1
	end
end