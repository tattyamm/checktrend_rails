class Amazontrend
  include ActiveModel::Model
  include Rss

  URL_AMAZON = "http://www.amazon.co.jp/gp/rss/bestsellers/books/ref=zg_bs_books_rsslink"

  def self.get
    uri = URI.parse(URL_AMAZON)
    response = Net::HTTP.get(uri)
    hash = Hash.from_xml(response)

    trendList = Array.new
    hash["rss"]["channel"]["item"].each { |item|
      eachItem = {
          "title" => item["title"],
          "link" => item["link"].strip,
          "pubDate" => DateTime.parse(item["pubDate"]).strftime("%Y-%m-%d"),
          "description" => self.getContributor(item["description"]) #item["description"],
      }
      trendList.push(eachItem)
    }
    trendList

    output = {
        "value" => {
            "title" => "amazon trend",
            "link" => URL_AMAZON,
            "description" => "",
            "item" => trendList
        }
    }
    output
  end

  def self.getContributor(str)
    if str =~ /riRssContributor\">(.+?)<span/
      strip_tags(CGI.unescapeHTML($1)).strip
    else
      ""
    end
  end

  def self.strip_tags(str)
    ActionController::Base.helpers.strip_tags(str)
  end

end