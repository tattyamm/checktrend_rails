require 'net/http'
require 'uri'

module Rss
  extend ActiveSupport::Concern

  class_methods do
    def getRssContent(url)
      uri = URI.parse(url)
      response = Net::HTTP.get(uri)
      hash = Hash.from_xml(response)

      rssList = Array.new
      hash["rss"]["channel"]["item"].each { |item|
        eachItem = {
            "title" => item["title"],
            "link" => item["link"],
            "pubDate" => DateTime.parse(item["pubDate"]).strftime("%Y-%m-%d"),
            "description" => item["description"],
        }
        rssList.push(eachItem)
      }
      rssList
    end
  end

end
