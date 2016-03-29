class Yahootrend
  include ActiveModel::Model
  include Rss

  URL_YAHOO = "http://searchranking.yahoo.co.jp/rss/burst_ranking-rss.xml"

  def self.get
    trendList = getRssContent(URL_YAHOO)
    output = {
        "value" => {
            "title" => "yahoo trend",
            "link" => URL_YAHOO,
            "description" => "",
            "item" => trendList
        }
    }
    output
  end

end
