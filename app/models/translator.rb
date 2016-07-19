require 'bing_translator'
require 'digest/md5'

class Translator
  include ActiveModel::Model

  def self.all(contents, from, to)
    translator = BingTranslator.new(ENV["MS_TRANSLATOR_CLIENT_ID"], ENV["MS_TRANSLATOR_CLIENT_SECRET"])
    # execute("こんにちは", "ja", "en")

    trendList = Array.new
    contents["value"]["items"].slice(0, 10).each { |item|
      eachItem = {
          "title" => execute(translator, item["title"], from, to),
          "link" => item["link"],
          "pubDate" => item["pubDate"],
          "description" => item["title"],
      }
      trendList.push(eachItem)
    }
    trendList

    output = {
        "value" => {
            "title" => contents["value"]["title"],
            "link" => contents["value"]["link"],
            "description" => contents["value"]["description"],
            "items" => trendList
        }
    }
    output
  end

  def self.execute(translator, str, from, to)
    cacheKey = "v0720" + "TRANSLATOR_" + from + "_" + to + "_" + Digest::MD5.hexdigest(str.force_encoding("UTF-8"))
    result = Rails.cache.fetch(cacheKey, expires_in: 90.minutes) do
      p "API使用 " + str
      begin
        translator.translate(str, :from => from, :to => to)
      rescue Exception => exception
        str
      end
    end
    p "翻訳: " + str + " -> "+ result + " cache key = " + cacheKey.force_encoding("UTF-8")
    result
  end

end