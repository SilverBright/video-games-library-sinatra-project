class GamesController < ApplicationController

  get '/games' do #display all the user's games
    if logged_in?
      @user = current_user
      session[:user_id] = @user.id
      @games = Game.all
      erb :'games/games'
    else
      redirect to '/login'
    end
  end

  get '/games/new' do #create - displays create game form  
    if logged_in?
      erb :'games/new'
    else
      redirect to '/login'
    end
  end

  post '/games' do #creates one game
    if params[:title] == "" || params[:platform] == ""
        redirect to "/games/new"
    else
      # @game = Game.create(title: params[:title], platform: params[:platform])
      @game = current_user.games.build(title: params[:title], platform: params[:platform])
      @game.save
      flash[:success] = "You've successfully created a new game!"
      redirect to "/games/#{@game.id}"
    end
  end

  get '/games/:id' do #displays one game based on ID in the url
    if logged_in?
      @game = Game.find_by_id(params[:id])
      erb :'games/show'
    else
      redirect to '/login'
    end
  end

  get '/games/:id/edit' do #displays edit form based on ID in the url
    if logged_in? # if the user is logged in
      @game = Game.find_by_id(params[:id]) # find the game by its param id and set it to an instance variable @game
      if @game && @game.user == current_user #compare that specific game to the game's user (creator) to the current user
        erb :'games/edit' #render the edit page (which has the update form)
      else 
        flash[:error] = "Oops!! #{@game.title} was not updated --  this is not your entry."
        redirect to '/games' #go back to the library
      end
    end
  end

  patch '/games/:id' do #modifies an existing game based on ID in the url
    if logged_in? && params[:title] == ""
        redirect to "/games/#{params[:id]}/edit"
    else
      @game = Game.find_by_id(params[:id])
      @game.update(title: params[:title], platform: params[:platform])
      @game.save
      flash[:success] = "You've successfully edited a game!"
      redirect "/games"
    end
  end

  delete '/games/:id/delete' do #deletes one game based on ID in the url
    @game = Game.find_by_id(params[:id])
    if logged_in?
      @user = current_user
      @game.delete
      flash[:success] = "You've successfully deleted a game!"
      redirect to '/games'
    else
      flash[:error] = "Oops, your game was not deleted"
      redirect to "/games/#{params[:id]}"
    end
  end
end
