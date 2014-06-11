require 'sinatra'
require_relative 'game'

	@@rolodex = Rolodex.new
	@@game = Game.new

get '/' do
	erb :index
end

post '/contacts' do
	@@rolodex.name = params[:name]
	@@game.start_game
end