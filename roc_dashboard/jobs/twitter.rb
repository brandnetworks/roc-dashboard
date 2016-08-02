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

SCHEDULER.every '600s', :first_in => 0 do |job|
  begin

    time = Time.new
    tweets = twitter.search("#{search_term}")

    if tweets
      #populate tweets
      tweets = tweets.map do |tweet|
        { name: tweet.user.name, body: tweet.text, avatar: tweet.user.profile_image_url_https, created_at: tweet.created_at, retweet: tweet.retweeted_status}
      end

      #filter out retweets, multiple tweets from the same user, and tweets not from today
      users = []
      recent_tweets = []
      j = 0
      for i in 0..tweets.length-1
        tweeted = "#{tweets[i][:created_at]}"[0..9]
        today = "#{time.year}-#{format('%02d', time.month)}-#{format('%02d', time.day)}"
        user = "#{tweets[i][:name]}"
        retweet = !tweets[i][:retweet].nil?
        tweets[i][:retweet] = ""
        if tweeted == today && !retweet && !users.include?(user)
          recent_tweets[j] = tweets[i]
          users.push(user)
          j+=1
        end
      end

      #remove links from tweets
      recent_tweets.each do |tweet|
        str=tweet[:body].gsub(/(?:f|ht)tps?:\/[^\s]+/, '')
        tweet[:body]=str
      end
      send_event('twitter_mentions', {comments: recent_tweets, length: recent_tweets.length})
    end
  rescue Twitter::Error => e
    puts "Twitter Error: #{e}"
    puts "\e[33mFor the twitter widget to work, you need to put in your twitter API keys in the jobs/twitter.rb file.\e[0m"
  end
end
