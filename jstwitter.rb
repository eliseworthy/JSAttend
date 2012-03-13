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
      when 'dm' then dm(parts[1], parts[2..-1].join(" "))  
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

  def dm(target, message)
    screen_names = @client.followers.collect{|follower| follower.screen_name}
      if screen_names.include? target
        dm = "d #{target} #{message}"
        tweet(dm)
      else
        puts "You ain't got no love from #{target}"
      end
  end

end

#Script
jst = JSTwitter.new
jst.run