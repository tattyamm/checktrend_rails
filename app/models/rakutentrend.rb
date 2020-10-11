class Rakutentrend
    include ActiveModel::Model
    include Rss

    # genleId 200162 = 本・雑誌・コミック
    def self.get(genre: "200162")
        application_id = 'e0e12265d6dc712a1d081ff58f8a8441'
        affiliate_id = '0f7e7e37.751871da.0f7e7e38.994f9407'
        url = 'https://app.rakuten.co.jp/services/api/IchibaItem/Ranking/20170628?applicationId=' + application_id + '&affiliateId=' + affiliate_id + '&format=json&carrier=0&genre=' + genre
        uri = URI.parse(url)
        puts "[URL]" + url
        json = Net::HTTP.get(uri)
        obj_list = JSON.parse(json)
        
        rankingList = Array.new
        obj_list["Items"].each{|obj_item|
            each_result = {}
            
            puts "[obj_item]"
            #puts obj_item

            eachItem = {
                "title" => obj_item["Item"]["itemName"],
                "link" => obj_item["Item"]["shopAffiliateUrl"],
                "pubDate" => DateTime.now.strftime("%Y-%m-%d"),
                "description" => "",
            }
            rankingList.push(eachItem)
            
          }

        puts rankingList

        output = {
            "value" => {
                "title" => "rakuten ranking",
                "link" => "https://www.rakuten.co.jp/",
                "description" => "",
                "items" => rankingList
            }
        }
        output

    end
      
end
