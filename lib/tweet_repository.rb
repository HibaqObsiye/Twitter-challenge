require'./lib/tweet.rb'
require'./lib/database_connection.rb'

class TweetRepository

    def all
        query = "SELECT id, message, time_stamp, user_id FROM tweets " #retrieves data in the form of a tuple
        params = []
        result_set = DatabaseConnection.exec_params(query, params)
        result_set[0] #unpacks it as a hash
        tweets = []
        
        result_set.each do |result|
            tweet = Tweet.new
            tweet.id = result["id"]
            tweet.message = result["message"]
            tweet.time_stamp = result["time_stamp"]
            tweet.user_id = result["user_id"]

            tweets << tweet
        end
      tweets
    end

    def find(id)
        query = "SELECT * FROM tweets WHERE id = $1"
        params = [id]

        result_set = DatabaseConnection.exec_params(query, params)
        result_set[0]
    end

    def create(tweet)
        query = "INSERT into tweets (message, time_stamp, user_id) VALUES($1, $2, $3)"
        params = [tweet.message, tweet.time_stamp, tweet.user_id]
        
        result_set = DatabaseConnection.exec_params(query, params)
    end

    def delete(id)
        query = "DELETE FROM tweets where id = $1"
        params = [id]

        result_set = DatabaseConnection.exec_params(query, params)

        return ''
    end
end