require './../lib/app/mailer/scrapper.rb'
require './../lib/app/twitter/twitter.rb'
require './../lib/app/mailer/gmail1.rb'
require './../lib/app/twitter/scrapper_twitter.rb'
require './../lib/views/done.rb'

class LaunchApp

  def initialize
    Mailer.new
    ScrappingTwitter.new
    RubyBot.new

  end
end
