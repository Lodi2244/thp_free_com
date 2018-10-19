require_relative './../app/mailer/scrapper_mail.rb'
require_relative '../app/mailer/mailer.rb'
require_relative '../app/twitter/scrapper_twitter.rb'
require_relative '../app/twitter/bot_twitter.rb'
require_relative 'done'

class LaunchApp

  def initialize
    Mailer.new
    BotRuby.new
    DoneProgram.new
  end
end
