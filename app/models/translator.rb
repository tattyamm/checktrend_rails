require 'digest/md5'
require 'securerandom'
require 'net/http'
require 'uri'
require 'json'
require 'oauth'


class Translator
  include ActiveModel::Model

  def self.all(contents, from, to)
    trendList = Array.new
    contents["value"]["items"].slice(0, 10).each { |item|
      eachItem = {
          "id" => SecureRandom.uuid,
          "title" => execute(text:item["title"], from_lang:from, to_lang:to),
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

  def self.execute(text: '', from_lang: 'ja', to_lang: 'en')
    #TODO 暫定
    consumer_key = ENV["MINHON_CONSUMER_KEY"]
    consumer_secret = ENV["MINHON_CONSUMER_SECRET"]
    name = ENV["MINHON_NAME"]
    url = "https://mt-auto-minhon-mlt.ucri.jgn-x.jp/api/mt/generalNT_#{from_lang}_#{to_lang}/"
 
    consumer = OAuth::Consumer.new(consumer_key, consumer_secret)
    endpoint = OAuth::AccessToken.new(consumer)

    text = text.byteslice(0..999).scrub('')# 1000バイトまで
    response = endpoint.post(url,{key: consumer_key, type: 'json', name: name, text: text})
    #puts response.body
    result = JSON.parse(response.body)
    result_text = result['resultset']['result']['text']

    puts "-----"
    puts "[翻訳設定]" + from_lang + "->" + to_lang
    puts "[翻訳入力]" + text
    puts "[翻訳結果]" + result_text

    result_text
  end

end