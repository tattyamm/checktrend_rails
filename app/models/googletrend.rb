require 'securerandom'

class Googletrend
  include ActiveModel::Model
  include Rss

  URL_GOOGLE = "https://trends.google.co.jp/trends/hottrends/atom/feed?pn=p4"

  def self.get
    trendList = getRssContent(URL_GOOGLE)
    output = {
        "value" => {
            "title" => "google trend",
            "link" => URL_GOOGLE,
            "description" => "",
            "items" => trendList
        }
    }
    output
  end

  def hello
    print "Hello ", @name, ".\n"
  end

end