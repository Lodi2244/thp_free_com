<<<<<<< HEAD:lib/app/twitter/scrapper_twitter.rb
# ligne très importante qui appelle la gem. Sans elle, le programme ne saura pas appeler Twitter
=======
>>>>>>> origin:lib/twitter/twitter.rb
require 'twitter'
require 'pry'
require 'dotenv'
require 'csv'
<<<<<<< HEAD:lib/app/twitter/scrapper_twitter.rb




  Dotenv.load
=======

class BotRuby
 # ligne très importante qui appelle la gem. Sans elle, le programme ne saura pas appeler Twitter

def initialize
Dotenv.load
initialize_keys
perform_tweet
end



def initialize_keys
>>>>>>> origin:lib/twitter/twitter.rb

# quelques lignes qui enregistrent les clés d'APIs
client = Twitter::REST::Client.new do |config|
  config.consumer_key        = ENV["TWITTER_API_KEY"]
  config.consumer_secret     = ENV["TWITTER_API_SECRET"]
  config.access_token        = ENV["TWITTER_ACCES_TOKEN"]
  config.access_token_secret = ENV["TWITTER_TOKEN_SECRET"]
end

<<<<<<< HEAD:lib/app/twitter/scrapper_twitter.rb

 CSV.foreach('../../db/db.csv') do |row|
 a = row.first + " ville"
p b = client.user_search(a).first.screen_name


csv = CSV.foreach('../../db/db.csv') do |row|
p csv
#csv do |row|
#  csv << b
=======
# ligne qui permet de follow une personne

def perform_tweet
CSV.foreach("../../db/db.csv") do |row|
  p row[3][1..-1]
 p client.follow(row[3])
>>>>>>> origin:lib/twitter/twitter.rb
end
end
