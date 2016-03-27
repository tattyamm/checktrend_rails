require 'net/http'
require 'uri'

class Googletrend
  include ActiveModel::Model

  URL_GOOGLE = "https://www.google.co.jp/trends/hottrends/atom/feed?pn=p4"

  def self.get
    puts URL_GOOGLE
    uri = URI.parse(URL_GOOGLE)
    response = Net::HTTP.get(uri)

    hash = Hash.from_xml(response)
    puts hash
    hash
  end

  def hello
    print "Hello ", @name, ".\n"
  end

end