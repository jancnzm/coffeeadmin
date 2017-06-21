class GiveawaysController < ApplicationController

  before_action :set_giveaway, only: [:show, :edit, :update, :destroy]
  def index
    @giveaways=Giveaway.all.order('id desc')
  end

  def new
    @giveaway = Giveaway.new
    @products=Product.all
  end

  def create
    @giveaway = Giveaway.new(giveaway_params)

    respond_to do |format|
      if @giveaway.save
        format.html { redirect_to giveaways_path, notice: 'giveaway was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end


  private
  # Use callbacks to share common setup or constraints between actions.
  def set_giveaway
    @giveaway = Giveaway.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def giveaway_params
    params.require(:giveaway).permit(:name ,:enable,:begindate, :enddate,:buyproduct_id, :giveproduct_id,:buynum, :givenum, :once)
  end

end
