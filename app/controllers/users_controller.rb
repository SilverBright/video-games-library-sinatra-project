class UsersController < ApplicationController

  get '/users' do
    @users = User.all #define instance variable for view
    erb :'users/index'
  end

  get '/register' do #read - loads page
    if logged_in?
      redirect to "/" #home page (index) which is defined in the application_controller
    else
      erb :'users/register' #registration page
    end
  end

  post '/register' do #creates a new user
   @user = User.create(username: params[:username], password: params[:password])
   @user.save
    if @user.valid?
      session[:user_id] = @user.id # starts a tracking session
      redirect "/games"
    elsif @user.invalid? && User.find_by(username: @user.username)
      flash[:error] = "That username is already taken, please choose another."
      redirect to '/register'
    else
      flash[:error] = "You must fill out all fields to sign up."
      redirect to '/register'
    end
  end

  get '/login' do #read - load page
    if !logged_in?
      erb :'users/login'
    else
      redirect to '/register'
    end
  end

  post '/login' do #create user login
   @user = User.find_by(:username => params[:username])
   if @user && @user.authenticate(params[:password])
     session[:user_id] = @user.id
     redirect to "/games"
   else
     flash[:error] = "Invalid username or password. Please try again."
     redirect '/login'
   end
 end

  get '/logout' do #read - load page
    if logged_in?
      flash[:success] = "Thanks for stopping by!"
      session.clear
      redirect to '/login'
    end
  else
    redirect to '/login'
  end
end

