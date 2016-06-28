require 'twitter'


#### Get your twitter keys & secrets:
#### https://dev.twitter.com/docs/auth/tokens-devtwittercom
twitter = Twitter::REST::Client.new do |config|
  config.consumer_key = ENV['CONSUMER_KEY']
  config.consumer_secret = ENV['CONSUMER_SECRET']
  config.access_token = ENV['ACCESS_TOKEN']
  config.access_token_secret = ENV['ACCESS_SECRET']
end

search_term = 'state from:ehmeals, OR from:roccitysammich, OR from:the_bentobox, OR from:stingrayfusion, OR from:macarollinroc, OR from:meatballtruckco, OR from:papagigs, OR from:bricknmotor, OR from:chowderup, OR from:martysmeats, OR from:wrapsonwheels, OR from:lepetitpoutine, OR from:tuscanwoodfired, OR from:MidnightSmokin, OR from:TheBrunchBoxRoc, OR from:meatthepress, OR from:robskabobsny, OR from:ChefsCaterROC'

SCHEDULER.every '10m', :first_in => 0 do |job|
  begin
    tweets = twitter.search("#{search_term}")

    if tweets
      tweets = tweets.map do |tweet|
        { name: tweet.user.name, body: tweet.text, avatar: tweet.user.profile_image_url_https }
      end
      send_event('twitter_mentions', comments: tweets, avatar: tweet.user.profile_image_url_https )
    end
  rescue Twitter::Error => e
    puts "Twitter Error: #{e}"
    puts "\e[33mFor the twitter widget to work, you need to put in your twitter API keys in the jobs/twitter.rb file.\e[0m"
  end
end
