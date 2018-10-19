# ligne très importante qui appelle la gem. Sans elle, le programme ne saura pas appeler Twitter
require 'twitter'
require 'pry'
require 'dotenv'
require 'csv'


class ScrappingTwitter
def initialize

Dotenv.load

# quelques lignes qui enregistrent les clés d'APIs
client = Twitter::REST::Client.new do |config|
  config.consumer_key        = ENV["TWITTER_API_KEY"]
  config.consumer_secret     = ENV["TWITTER_API_SECRET"]
  config.access_token        = ENV["TWITTER_ACCES_TOKEN"]
  config.access_token_secret = ENV["TWITTER_TOKEN_SECRET"]
end


 CSV.foreach('../../db/db.csv') do |row|
   a = row[1]
 if client.user_search(a) != nil
 if  client.user_search(a).first != nil
 p [row[1],client.user_search(a).first.screen_name]

 table = CSV.read('../../db/db.csv', {headers: true, col_sep: ", "})

# Add another col, row by row:
i = 1
a = b[0]
puts table
table.each do |row|
  row[a] = b[i]
  i += 1

table = CSV.read("../../db/db.csv").flatten
department = []
name = []
email = []
i = 0
j = 1
k = 2
n = 0
while n < 3
department[n] = table[i]
name[n] = table[j]
email[n] = table[k]
i += 3
j += 3
k += 3
n += 1
end
CSV.open("../../db/db.csv","a+") {|csv| array.to_a.each {|elem| csv << elem} }
end
end
end

end
end
