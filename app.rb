require 'sinatra/base'
require 'sinatra/reloader'
require'./lib/database_connection.rb'  
require './lib/tweet_repository.rb'
require './lib/tweet.rb'

DatabaseConnection.connect('twitter_test')
class Application < Sinatra::Base
  enable :sessions
  # This allows the app code to refresh
  # without having to restart the server.
  configure :development do
    register Sinatra::Reloader
    also_reload 'lib/tweet_repository'
  end


end

