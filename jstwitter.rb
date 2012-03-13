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
      when 's' then spam_my_followers(message) 
      when 'elt' then everyones_last_tweet 
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

  def followers_list
    screen_names = @client.followers.collect{|follower| follower.screen_name}
    #@client.followers.collect(&:screen_name)
    return screen_names
  end

  def spam_my_followers(message)
    followers_list.each do |target|
      dm(target, message)
    end
    puts "Spam complete!"
  end

  def everyones_last_tweet
    friends = @client.friends
    friends = friends.sort_by{|friend| screen_name.downcase}

    friends.each do |friend|

      timestamp = friend.status.created_at
      tweet_date = Date.parse(timestamp)

      puts "#{friend.screen_name} said the following at #{tweet_date.strftime("%A, %b %d")}:"
      puts friends.status.text
      puts "" 
    end
  end

end

#Script
jst = JSTwitter.new
jst.run