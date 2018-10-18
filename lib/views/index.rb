require './../lib/app/mailer/scrapper.rb'
require './../lib/app/twitter/twitter.rb'
require './../lib/app/mailer/gmail1.rb'
require './../lib/app/twitter/scrapper_twitter.rb'
require './../lib/views/done.rb'

class LaunchApp

  def initialize
    Initialize_db.new
    if gets.chomp == 1
      TownhallRun.new
    end
    Mailer.new
    ScrappingTwitter.new
    RubyBot.new

  end
end
