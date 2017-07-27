class UserprofitsController < ApplicationController

  def index
    @useramounts=Useramount.all.paginate(:page => params[:page], :per_page => 20).order("id desc")
    @useramountsum = Useramount.sum('amount')
  end

end
