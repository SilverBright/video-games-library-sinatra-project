class GamesController < ApplicationController

  get '/games' do
    if logged_in?
      @games = Game.all
      erb :'games/games'
    else
      redirect to '/login'
    end
  end

  get '/games/new' do
    if logged_in?
      erb :'games/create_game'
    else
      redirect to '/login'
    end
  end

  post '/games' do
    if logged_in?
      if params[:titles] == ""
        redirect to "/games/new"
      else
        @game = current_user.games.build(titles: params[:titles])
        if @game.save
          redirect to "/games/#{@game.id}"
        else
          redirect to "/games/new"
        end
      end
    else
      redirect to '/login'
    end
  end

  get '/games/:id' do
    if logged_in?
      @game = Game.find_by_id(params[:id])
      erb :'games/show_game'
    else
      redirect to '/login'
    end
  end



end