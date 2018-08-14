require 'pry'

class GamesController < ApplicationController

  # The params hash is a “rack” object that is accessible through Sinatra’s request object. 
  # The params hash stores information posted by html forms as a hash which contains a key-value pair. 
  # The key defaults to the value of the <input>’s name=“attribute”, and the data that the user submits is the value
  # of that key-value pair.

  # The params hash that is defined in the controller, stores the form data submitted by the user
  #the user’s entry will be the value of a key-value pair.

  get '/games' do #display all games by all users
    if logged_in?
      @user = current_user
      session[:user_id] = @user.id
      @games = Game.all
      erb :'games/games' #renders the page for view if the user is logged in
    else
      redirect to '/login' #sends the user to a different page if not logged in
      # redirect loses state, or is no longer in scope of the controller, and goes to make a new request
    end
  end

  get '/games/new' do #create - displays create game form  
    if logged_in?
      erb :'games/new' #response cycle
    else
      redirect to '/login' #new request/response cycle
    end
  end

  post '/games' do #creates one game
    
    if params[:title] == "" || params[:platform] == ""
      flash[:error] = "Oops, you need to fill out all the fields."
       redirect to "/games/new"
    else
      @game = current_user.games.build(title: params[:title], platform: params[:platform])
      #                               (:title => params[:title], :platform => params[:platform])
      #                               (key    => params[:value],  key      => params[:value])
      #                   params => {"title"=>"Tetris", "platform"=>"mobile"}                     
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
    if logged_in? # ADDED LINE. if the user is logged in
      @game = Game.find_by_id(params[:id]) #  find the game by its param id and set it to an instance variable @game
      if @game && @game.user == current_user #ADDED LINE. compare that specific game to the game's user (creator) to the current user
        erb :'games/edit' #render the edit page (which has the update form)
      else 
        flash[:error] = "Oops!! #{@game.title} is not your title -- Please select one of your own titles."
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
