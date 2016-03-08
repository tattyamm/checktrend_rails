class ApiController < ApplicationController

  def show
    @personal = {'name' => 'Yamada', 'old' => 28}
    
    respond_to do |format|
      format.json {render :json => @personal}
      format.xml  {render :xml => @personal}
    end
  end

end
