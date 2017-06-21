class IdcardsController < ApplicationController
  before_action :set_idcard, only: [:show, :edit, :update, :destroy]
  def new
    @idcard = Idcard.new
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_idcard
    @idcard = Idcard.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def idcard_params
    params.require(:idcard).permit(:user_id ,:uuid, :idfront,:idback)
  end

end
