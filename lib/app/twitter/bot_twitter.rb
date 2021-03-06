require 'twitter'
require 'pry'
require 'dotenv'
require 'csv'

class BotRuby
 # ligne très importante qui appelle la gem. Sans elle, le programme ne saura pas appeler Twitter

def initialize
Dotenv.load
initialize_keys
perform_tweet
end


def initialize_keys

# quelques lignes qui enregistrent les clés d'APIs
@client = Twitter::REST::Client.new do |config|
  config.consumer_key        = ENV["TWITTER_API_KEY"]
  config.consumer_secret     = ENV["TWITTER_API_SECRET"]
  config.access_token        = ENV["TWITTER_ACCES_TOKEN"]
  config.access_token_secret = ENV["TWITTER_TOKEN_SECRET"]
end
end

# ligne qui permet de follow une personne

def perform_tweet
CSV.foreach(File.expand_path("../../../../db/db.csv", __FILE__)) do |row|
  if row[3] != ""
  @client.follow(row[3])
end
end
end
end
