# ligne très importante qui appelle la gem. Sans elle, le programme ne saura pas appeler Twitter
require 'twitter'
require 'pry'
require 'dotenv'
require 'csv'




  Dotenv.load

# quelques lignes qui enregistrent les clés d'APIs
client = Twitter::REST::Client.new do |config|
  config.consumer_key        = ENV["TWITTER_API_KEY"]
  config.consumer_secret     = ENV["TWITTER_API_SECRET"]
  config.access_token        = ENV["TWITTER_ACCES_TOKEN"]
  config.access_token_secret = ENV["TWITTER_TOKEN_SECRET"]
end


 CSV.foreach('../../db/db.csv') do |row|
 a = row.first + " ville"
p b = client.user_search(a).first.screen_name


csv = CSV.foreach('../../db/db.csv') do |row|
p csv
#csv do |row|
#  csv << b
end
end
