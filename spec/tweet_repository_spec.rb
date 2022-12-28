require './lib/tweet' 
require './lib/tweet_repository.rb'
require 'spec_helper'

def reset_tweets_table
    seed_sql = File.read('./databases/tweets_seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'twitter_test' })
    connection.exec(seed_sql)
end

describe TweetRepository do
    before(:each) do 
        reset_tweets_table
        reset_users_table
    end

    context "given list of tweets" do
        it "returns all tweets" do
            tweets = TweetRepository.new
            all_tweets = tweets.all
            
            expect(all_tweets.count).to eq(2)
        end
    end
        it "returns the first tweet" do
            tweets = TweetRepository.new
            all_tweets = tweets.all
            first_tweet = all_tweets.first
           
            expect(first_tweet.message).to eq("hello world")
            expect(first_tweet.time_stamp).to eq("2022-12-17 21:06:10")
            expect(first_tweet.user_id).to eq("1")
        end

    context "Given a list of tweets" do
        it "finds specific entry by id = 1" do
            tweets = TweetRepository.new
            first_tweet = tweets.find(1)

            expect(first_tweet["message"]).to eq("hello world")
        end
    end
        it "finds specific tweets by id = 2 " do
            tweets = TweetRepository.new
            second_tweet = tweets.find(2)

            expect(second_tweet["message"]).to eq("welcome back")
        end

    context "given an entry of a tweet" do
        it "creates the tweet and stores in the database" do
            tweet_repository = TweetRepository.new
            tweet = Tweet.new
            tweet.message = "new message"
            tweet.time_stamp = "2022-12-19 17:54:10"
            tweet_repository.create(tweet)

            all_tweets = tweet_repository.all
            expect(all_tweets.count).to eq(3)
            
        end

        it "shows the message of new created tweet" do
            tweet_repository = TweetRepository.new
            tweet = Tweet.new
            tweet.message = "new message"
            tweet.time_stamp = "2022-12-19 17:54:10"
            tweet_repository.create(tweet)

            all_tweets = tweet_repository.all

            new_tweet = all_tweets[2]
           
            expect(new_tweet.message).to eq("new message")
        end
    end

    context "Given an entry of a tweet" do
        it "deletes it" do
            tweet_repository = TweetRepository.new
            all_tweets = tweet_repository.all
            tweet_repository.delete(1)
            p all_tweets
            expect(all_tweets.count).to eq(2)
            
        end
    end
    

    

end