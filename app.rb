require 'sinatra/base'
require 'sinatra/reloader'
require'./lib/database_connection.rb'  
require './lib/tweet_repository.rb'
require './lib/user_repository.rb'
require './lib/user.rb'
require './lib/tweet.rb'  
require './lib/user_params.rb'
require 'time'

DatabaseConnection.connect('twitter_test')
class Application < Sinatra::Base
  # This allows the app code to refresh
  # without having to restart the server.
  configure :development do
    register Sinatra::Reloader
    also_reload 'lib/tweet_repository'
  end
  enable :sessions

  get '/' do
    return erb(:homepage)
  end

  get '/tweets' do
    tweets  = TweetRepository.new
    users = UserRepository.new

    @tweets = tweets.all
   
    @users = users.all
    return erb(:tweets)
  end

  post '/tweets' do
    tweet = Tweet.new
    tweet.message = params[:message]
    tweet.time_stamp = Time.new.strftime("%Y/%m/%d %k:%M:%S")
    tweet.user_id = session[:user]["id"]
    repo  = TweetRepository.new
    repo.create(tweet)

    return erb(:tweets_created)
  end

  get '/signup' do
    return erb(:sign_up)
  end

  post '/signup' do
    checking_params = UserParams.new(params[:new_name], params[:new_username], params[:new_email], params[:new_password])
  
    if empty_user_params?
      erb(:empty_user_params)
    elsif checking_params.invalid_params? 
      erb(:invalid_email_params)
    else
      @new_user = create_user
      
      return erb(:successful_signup)
    end
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

  private

  def create_user
    repo = UserRepository.new
    @new_user = User.new

    @new_user.id = (repo.all.length + 1)
    @new_user.name = params[:new_name]
    @new_user.username = params[:new_username]
    @new_user.email = params[:new_email]
    @new_user.password = params[:new_password]
    repo.create(@new_user)
     session[:user] = repo.sign_in(@new_user.email, @new_user.password)
  end

  def empty_user_params?
    params[:new_name] == "" || params[:new_username] == "" || params[:new_username] == "" || params[:new_email] == "" || params[:new_password] == "" || params[:new_password] == "" 
  end




end

