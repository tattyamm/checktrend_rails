class ApiController < ApplicationController

  def show
    @provider = params[:provider]

    googletrend = Googletrend.get

    respond_to do |format|
      format.json {render :json => googletrend}
      format.xml  {render :xml => googletrend}
    end
  end

end
