require 'net/http'
require 'uri'
require 'securerandom'

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
            "id" => SecureRandom.uuid,
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
