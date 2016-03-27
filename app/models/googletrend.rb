require 'net/http'
require 'uri'

class Googletrend
  include ActiveModel::Model

  URL_GOOGLE = "https://www.google.co.jp/trends/hottrends/atom/feed?pn=p4"

  def self.get
    uri = URI.parse(URL_GOOGLE)
    response = Net::HTTP.get(uri)
    hash = Hash.from_xml(response)

    trendList = Array.new
    hash["rss"]["channel"]["item"].each { |item|
      eachItem = {
          "title" => item["title"],
          "link" => item["link"],
          "pubDate" => DateTime.parse(item["pubDate"]).strftime("%Y-%m-%d"),
          "description" => item["description"],
      }
      trendList.push(eachItem)
    }

    trendList

  end

  def hello
    print "Hello ", @name, ".\n"
  end

end