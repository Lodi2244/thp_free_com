require './../lib/app/mailer/scrapper_mail.rb'
require './../lib/app/mailer/mailer.rb'
require './../lib/app/twitter/scrapper_twitter.rb'
require './../lib/app/twitter/bot_twitter.rb'
require './../lib/views/done.rb'

class LaunchApp

  def initialize
    Mailer.new
    RubyBot.new

  end
end
