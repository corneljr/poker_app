require_relative 'game'
require 'sinatra'


	@@rolodex = Rolodex.new
	@@game = Game.new(@@rolodex)

get '/' do
	erb :index
end

post '/player' do
	@@rolodex.name = params[:name]
	@@game.start_game
	redirect to('/new_game')
end

get '/new_game' do
	erb :new_game
end

get '/play_again' do
	@@game = Game.new(@@rolodex)
	@@game.start_game
	erb :new_game
end