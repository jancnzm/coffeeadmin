class WxusersController < ApplicationController

  before_action :set_wxuser, only: [:show, :edit, :update, :destroy]
  def index
    @wxusers=Wxuser.all.paginate(:page => params[:page], :per_page => 20).order("id desc")
    @wxusercount = Wxuser.count
    @dgts=Dgt.all
  end

  def edit
@dgts=Dgt.all

  end

  def update
    respond_to do |format|
      if @wxuser.update(wxuser_params)
        format.html { redirect_to wxusers_path, notice: 'Admin was successfully updated.' }
        format.json { render :show, status: :ok, location: @wxuser }
      else
        format.html { render :edit }
        format.json { render json: @wxuser.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_wxuser
    @wxuser = Wxuser.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def wxuser_params
    params.require(:wxuser).permit(:openid ,:nickname, :sex,:address,:headimgurl,:dgt_id,:receipt)
  end

end
