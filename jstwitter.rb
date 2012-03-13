require 'jumpstart_auth'

class JSTwitter
  attr_reader :client

  def initialize
    puts "Initializing"

    @client = JumpstartAuth.twitter
  end

  def run
    puts "Welcome to the JSTwitter client!"

    command = ""
    while command != "q"
      printf "enter command: "
      
      input = gets.chomp
      parts = input.split(" ")
      command = parts[0]
      message = parts[1..-1].join(" ")

      case command
      when 'q' then puts 'See ya later!'
      when 't' then tweet(message)
      else
        puts "What the heck are you talking about with #{command}?"
      end
    end
  end

  def tweet(message)

    if message.length >= 140
      puts "your tweet is too dang long, son."
    else
      @client.update(message)
    end
  end

end

#Script
jst = JSTwitter.new
jst.run