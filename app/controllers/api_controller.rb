class ApiController < ApplicationController

  def show
    @provider = params[:provider]

    # 取得
    trendList = Rails.cache.fetch("trendlist-" + @provider, expires_in: 3.seconds) do
      case @provider
        when "google"
          Googletrend.get
        when "yahoo"
          Yahootrend.get
        when "twitter"
          Twittertrend.get
        when "amazon"
          Amazontrend.get
        when "youtube"
          Youtubetrend.get
        when "rakuten"
          Rakutentrend.get
        else
          ["error"]
      end
    end

    # 翻訳
    if (params.has_key?(:from) && params.has_key?(:to)) then
      trendList = Rails.cache.fetch("trendlist-" + @provider + params[:from] + params[:to], expires_in: 10.seconds) do
        Translator.all(trendList, params[:from], params[:to])
      end
    else
    end

    respond_to do |format|
      format.json {render :json => trendList}
      format.xml  {render :xml => trendList}
    end
  end

end
