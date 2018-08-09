require './config/environment'

class ApplicationController < Sinatra::Base

  register Sinatra::Flash #flash apability
  require 'sinatra/flash'#flash capability

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions #make cookies
    set :session_secret, "secret" #encrypts the cookie
    set :method_override, true #allows for patch and delete methods
  end

  get "/" do #the index page is defined as "/" here
    erb :index
  end

  helpers do  #define the current user and login session

    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end
  end 
end