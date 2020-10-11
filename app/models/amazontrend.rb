# 売り上げ実績が無いと、このAPIは使えないらしい
# 動くことも希にあるが、基本的にはエラーとなる
# エラーメッセージ : The request was denied due to request throttling. Please verify the number of requests made per second to the Amazon Product Advertising API.

class Amazontrend
  include ActiveModel::Model
  include Rss

  URL_AMAZON = "https://www.amazon.co.jp/%E6%9C%AC-%E6%9B%B8%E7%B1%8D-%E9%80%9A%E8%B2%A9/b?ie=UTF8&node=465392"

  def self.get

    request = Vacuum.new(marketplace: ENV["AMAZON_PAAPI_MARKETPLACE"],
                     access_key: ENV["AMAZON_PAAPI_ACCESS_KEY"],
                     secret_key: ENV["AMAZON_PAAPI_SECRET_KEY"],
                     partner_tag: ENV["AMAZON_PAAPI_PARTNER_TAG"])
    response = request.search_items(
      keywords: '*',
      browse_node_id: "465392",
      sort_by: "Featured", #Featured...注目順(Sorts results with featured items having higher rank)
      resources: [
        "ItemInfo.Title",
        "BrowseNodeInfo.WebsiteSalesRank"
        ]
      )
    puts response.to_h
    puts response.to_h["SearchResult"]["Items"]

    trendList = Array.new
    response.to_h["SearchResult"]["Items"].each { |item|
      eachItem = {
        "title" => item["ItemInfo"]["Title"]["DisplayValue"],
        "link" => item["DetailPageURL"],
        "pubDate" => DateTime.now.strftime("%Y-%m-%d"),
        "description" => ""
      }
      trendList.push(eachItem)
    }

    output = {
        "value" => {
            "title" => "amazon featured",
            "link" => URL_AMAZON,
            "description" => "",
            "items" => trendList
        }
    }

    output



  end


end
