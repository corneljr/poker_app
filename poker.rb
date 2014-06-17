require_relative 'ranker'
require_relative 'assets'

require 'sinatra'
require 'data_mapper'
enable 'sessions'

DataMapper.setup(:default, "sqlite:database.sqlite3") 

class Record
	include DataMapper::Resource

	property :id, Serial
	property :user, String
	property :outcome, Integer
	property :balance, Integer
end

DataMapper.finalize
DataMapper.auto_upgrade!

class Game
	attr_accessor :player, :computer, :user, :outcome, :bet

	def initialize
		@dealer = Dealer.new
		@player = Player.new
		@computer = Player.new
	end

	def start_game
		@dealer.deal(@player,@computer)
	end

	def outcome
		Ranker.outcome(@player.hand,@computer.hand)
	end

	def display_hand(hand)
		Ranker.display_hand(hand)
	end
end

get '/' do
	erb :index
end

post '/newgame' do
	@record = Record.create(
		:user => params[:name],
		:outcome => "",
		:balance => 0
	)
	session['name'] = @record.user
	p session['name']
	@@game = Game.new
	@@game.start_game
	redirect to('/start_game')
end

get '/start_game' do
	erb :new_game
end

post '/bet' do
	game_outcome = Ranker.outcome(@@game.player.hand,@@game.computer.hand)
	name = "dave"
	@contact = Record.get(name)
	@contact.outcome = game_outcome
	@contact.balance += params[:bet]
	redirect to('/end_game')
end

get '/end_game' do
	erb :end_game
end








