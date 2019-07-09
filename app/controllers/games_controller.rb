class GamesController < ApplicationController

  get '/games' do
    if logged_in?
      @user = current_user
      session[:user_id] = @user.id
      @games = Game.all
      erb :'games/games'
    else
      redirect to '/login' 
    end
  end

  get '/games/new' do 
    if logged_in?
      erb :'games/new'
    else
      redirect to '/login'
    end
  end

  post '/games' do
    if params[:title] == "" || params[:platform] == ""
      flash[:error] = "Oops, you need to fill out all the fields."
      redirect to "/games/new"
    else
      @game = current_user.games.build(title: params[:title], platform: params[:platform])                    
      @game.save
      flash[:success] = "You've successfully created a new game!"
      redirect to "/games/#{@game.id}"
    end
  end

  get '/games/:id' do
    if logged_in?
      @game = Game.find_by_id(params[:id])
      erb :'games/show' 
    else
      redirect to '/login' 
    end
  end

  get '/games/:id/edit' do
    @game = Game.find_by_id(params[:id])
    if @game && @game.user == current_user
      erb :'games/edit'
    else
      flash[:error] = "Oops!! #{@game.title} is not your title -- Please select one of your own titles."
      redirect to '/games'
    end
  end

  patch '/games/:id' do 
    @game = Game.find_by_id(params[:id])
    @game && @game.user == current_user 
    if params[:title] == "" || params[:platform] == ""
      flash[:error] = "Your game did not update.  Title and Platform fields cannot be blank"
      redirect to '/games'
    else
      @game.update(title: params[:title], platform: params[:platform]) 
      @game.save
      flash[:success] = "You've successfully updated your entry to: #{@game.title}"
      redirect to '/games'
    end
  end

  delete '/games/:id/delete' do
    @game = Game.find_by_id(params[:id])
    if @game && @game.user == current_user
      @game.delete
      flash[:success] = "You have successfully deleted #{@game.title}."
      redirect to '/games'
    else
      flash[:error] = "Oops!! #{@game.title} is not your title -- Please select one of your own titles."
      redirect to '/games'
    end
  end
  
end