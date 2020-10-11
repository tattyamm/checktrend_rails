class ApiController < ApplicationController

  def show
    @provider = params[:provider]

    # 取得
    trendList = Rails.cache.fetch(@provider) do
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
      trendList = Translator.all(trendList, params[:from], params[:to])
    else
    end

    respond_to do |format|
      format.json {render :json => trendList}
      format.xml  {render :xml => trendList}
    end
  end

end
