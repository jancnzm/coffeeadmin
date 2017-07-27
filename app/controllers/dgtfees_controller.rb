class DgtfeesController < ApplicationController

  def index
    @dgtfees=Dgtfee.all.paginate(:page => params[:page], :per_page => 20).order("id desc")
    @dgtfeesum=Dgtfee.sum('amount')
    if session[:dgtid].to_i > 0
      @dgtfees=Dgtfee.where('dgt_id=?',session[:dgtid]).paginate(:page => params[:page], :per_page => 20).order("id desc")
      @dgtfeesum=@dgtfees.sum('amount')
    end
    @dgts=Dgt.all
  end

end
