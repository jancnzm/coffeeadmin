class ProfitsController < ApplicationController

  def index
    @profits=Profit.all.paginate(:page => params[:page], :per_page => 20).order("id desc")
    @profitsum = Profit.sum('profit')
  end

end
