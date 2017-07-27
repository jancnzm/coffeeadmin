class UserinoutcountsController < ApplicationController
  before_action :set_userinoutcount, only: [:show, :edit, :update, :destroy]
def index
  @userinoutcounts=User.where("isnew=? and balance > ?",0,0).paginate(:page => params[:page], :per_page => 20).order("id desc")
end

  def edit
@withdraws = @userinoutcount.withdraws
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_userinoutcount
    @userinoutcount = User.find(params[:id])
  end

end
