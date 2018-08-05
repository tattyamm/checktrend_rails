class Youtubetrend
  include ActiveModel::Model
  include Rss

  URL_YOUTUBE = "https://www.youtube.com/feeds/videos.xml?playlist_id=PLrEnWoR732-BHrPp_Pm8_VleD68f9s14-"

  def self.get
    uri = URI.parse(URL_YOUTUBE)
    response = Net::HTTP.get(uri)
    hash = Hash.from_xml(response)

    trendList = Array.new
    hash["feed"]["entry"].each { |item|
      link = item["link"]["href"]
      eachItem = {
          "title" => item["title"],
          "link" => link,
          "pubDate" => DateTime.parse(item["published"]).strftime("%Y-%m-%d"),
          "description" => ""
      }
      trendList.push(eachItem)
    }
    trendList

    output = {
        "value" => {
            "title" => "youtube trend",
            "link" => URL_YOUTUBE,
            "description" => "",
            "items" => trendList
        }
    }

    output
  end


end
