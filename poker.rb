require_relative 'game'
require 'sinatra'


	@@rolodex = Rolodex.new
	@@game = Game.new

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