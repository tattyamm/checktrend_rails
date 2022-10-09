require 'securerandom'
# promoted_content というパラメタがある

class Twittertrend
  include ActiveModel::Model

  def self.get
    trendList = Array.new
    getTrend.each { |item|
      eachItem = {
          "id" => SecureRandom.uuid,
          "title" => item.name,
          "link" => "https://twitter.com/search?" + item.url.query,
          "pubDate" => DateTime.now.strftime("%Y-%m-%d"),
          "description" => "",
      }
      trendList.push(eachItem)
    }
    trendList


    output = {
        "value" => {
            "title" => "twitter trend",
            "link" => "https://twitter.com/",
            "description" => "",
            "items" => trendList
        }
    }
    output
  end

  def self.getTrend
    twClient = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["consumerKey"]
      config.consumer_secret     = ENV["consumerSecret"]
      #  tokenを渡さないでApplication-only authenticationにする
      #  config.access_token        = TW_ACCESS_TOKEN
      #  config.access_token_secret = TW_ACCESS_TOKEN_SECRET
    end
    twClient.trends(23424856)

  end

end