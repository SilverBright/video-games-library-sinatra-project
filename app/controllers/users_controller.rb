class UsersController < ApplicationController

  get '/register' do
    if !logged_in?
      erb :'users/register', locals: {message: "Please create a new account."}
    else
      redirect to '/games'
    end
  end

  post '/register' do
    if params[:username] == "" || params[:password] == ""
      redirect to '/register'
    else
      @user = User.new(:username => params[:username], :password => params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect to '/games'
    end
  end

  get '/login' do
    if !logged_in?
      erb :'users/login'
    else
      redirect to '/register'
    end
  end

  post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to "/games"
    else
      redirect to '/login'
    end
  end

  get '/logout' do
    if logged_in?
      session.destroy
      redirect to '/login'
    else
      redirect to '/'
    end
  end

end

