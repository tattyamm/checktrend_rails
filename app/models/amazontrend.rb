class Amazontrend
  include ActiveModel::Model
  include Rss

  URL_AMAZON = "https://www.amazon.co.jp/gp/rss/bestsellers/books/ref=zg_bs_books_rsslink"
  TAG_AMAZON = "iphonect-22"

  def self.get
    uri = URI.parse(URL_AMAZON)
    response = Net::HTTP.get(uri)
    hash = Hash.from_xml(response)

    trendList = Array.new
    hash["rss"]["channel"]["item"].each { |item|
      link = item["link"].strip + "&tag=" + TAG_AMAZON
      asin = link.match(%r{.*/dp/(.+?)/.*})[1]
      link_short = "https://amazon.jp/dp/" + asin + "?tag=" + TAG_AMAZON

      eachItem = {
          "title" => item["title"],
          "link" => link_short,
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
            "items" => trendList
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