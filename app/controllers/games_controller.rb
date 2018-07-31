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
    # if logged_in?
      if params[:titles] == "" || params[:platform] == ""
        redirect to "/games/new"
      else
        @game = Game.create(params)
        @game.save
        flash[:success] = "You have created a new game"
          redirect to "/games/#{@game.id}"
        # else
        #   redirect to "/games/new"
    #     end
    #   end
    # else
    #   redirect to '/login'
    end
  end

  get '/games/:id' do
    if logged_in?
      @user = current_user
      @game = Game.find_by_id(params[:id])
      erb :'games/show_game'
    else
      redirect to '/login'
    end
  end

get '/games/:id/edit' do
    if logged_in?
      @game = Game.find_by_id(params[:id])
      if @game.user == current_user
        erb :'games/#{params[:id]/edit_game'
      else
        redirect to "/games/edit_game"
      end
    end
  end

  patch '/games/:id' do
    if logged_in? && params[:titles] == ""
        redirect to "/games/#{params[:id]}/edit"
      else
        @game = Game.find_by_id(params[:id])
        @game.update(titles: params[:titles], platform: params[:platform])
        @game.save
        flash[:success] = "Successfully edited game.!!"
      redirect "/games/#{params[:id]}"
         end
       end
 

  delete '/games/:id/delete' do
    @game = Game.find_by_id(params[:id])
    if logged_in?
      @user = current_user
      if @user.games.include?(@game)
        @game.delete
        flash[:success] = "Successfully deleted game."
        redirect to '/games'
    else
      redirect to "/games/#{params[:id]}"

      end
    end
  end
end
