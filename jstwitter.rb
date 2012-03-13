require 'jumpstart_auth'

class JSTwitter
  attr_reader :client

  def initialize
    puts "Initializing"

    @client = JumpstartAuth.twitter
  end

  def tweet(message)
    @client.update(message)
  end

end

#Script
jst = JSTwitter.new
jst.tweet("JSTwitter initialized by @eliseworthy")