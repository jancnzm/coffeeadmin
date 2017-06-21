class DgtfeesController < ApplicationController

  def index
    @dgtfees=Dgtfee.all
    @dgtfeesum=Dgtfee.sum('amount')
    if session[:dgtid].to_i > 0
      @dgtfees=Dgtfee.where('dgt_id=?',session[:dgtid])
      @dgtfeesum=@dgtfees.sum('amount')
    end
    @dgts=Dgt.all
  end

end
