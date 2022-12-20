require 'sinatra/base'
require 'sinatra/reloader'
require'./lib/database_connection.rb'  
require './lib/tweet_repository'
 require './lib/user_repository.rb'
require './lib/user.rb'
require './lib/tweet.rb'  
require 'time'

DatabaseConnection.connect('twitter_test')
class Application < Sinatra::Base
  enable :sessions
  # This allows the app code to refresh
  # without having to restart the server.
  configure :development do
    register Sinatra::Reloader
    also_reload 'lib/tweet_repository'
  end

  get '/' do
    return erb(:homepage)
  end

  get '/tweets' do
    repo  = TweetRepository.new
  
    @tweets = repo.all
    
    return erb(:tweets)
  end

  post '/tweets' do
    tweet = Tweet.new
    tweet.message = params[:message]
    tweet.time_stamp = Time.new.strftime("%Y/%m/%d %k:%M:%S")
    tweet.user_id = params[:user_id]
    repo  = TweetRepository.new
    repo.create(tweet)

    return erb(:tweets_created)
  end

  get '/signup' do
    return erb(:sign_up)
  end

  post '/signup' do
    repo = UserRepository.new
    user = User.new

    user.id = (repo.all.length + 1)
    user.name = params[:name]
    user.username = params[:username]
    user.email = params[:email]
    user.password = params[:password]
    repo.create(user)
      p user
    return erb(:successful_signup)
  end

  get '/login' do
    erb(:login)
  end

  post '/login' do
    user = UserRepository.new
   
    email = params[:email]
    password = params[:password]
   
   status = user.sign_in(email, password)
 
   if status == nil
    return erb(:user_not_recognised)
   elsif status == false
      return erb(:user_login_error)
   else
    @user = user.find_by_email(email)
    return "successful login"
   end
   
  end




end

