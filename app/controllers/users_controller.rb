class UsersController < ApplicationController

  get '/signup' do
    if !logged_in?
      erb :'users/create_user', locals: {message: "Please create a new account."}
    else
      redirect to '/games'
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect to '/signup'
    else
      @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect to '/games'
    end
  end


  get '/login' do
    if !logged_in?
      erb :'users/login'
    else
      redirect to '/games'
    end
  end

end

