class ApiController < ApplicationController

  def show
    @provider = params[:provider]

    trendList =
      case @provider
        when "google"
          Googletrend.get
        when "yahoo"
          Yahootrend.get
        when "amazon"
          Amazontrend.get
        else
          ["error"]
      end

    respond_to do |format|
      format.json {render :json => trendList}
      format.xml  {render :xml => trendList}
    end
  end

end
