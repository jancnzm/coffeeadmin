class GiveawaysController < ApplicationController

  before_action :set_giveaway, only: [:show, :edit, :update, :destroy]
  def index
    @giveaways=Giveaway.all.order('id desc')
  end

  def new
    @giveaway = Giveaway.new
    @products=Product.all
    @giveawayproducts=@giveaway.giveawayproducts
  end

  def create
    @giveaway = Giveaway.new(giveaway_params)

    respond_to do |format|
      if @giveaway.save
        format.html { redirect_to edit_giveaway_path(@giveaway), notice: 'giveaway was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def edit
    @giveawayproducts=@giveaway.giveawayproducts
    @giveawaybusines=@giveaway.giveawaybusines
    @busines=Busine.all
    @products=Product.all
  end

  def update
    respond_to do |format|
      if @giveaway.update(giveaway_params)
        format.html { redirect_to giveaways_path, notice: 'Giveaway was successfully updated.' }
        format.json { render :show, status: :ok, location: @giveaway }
      else
        format.html { render :edit }
        format.json { render json: @giveaway.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @giveaway.destroy
    respond_to do |format|
      format.html { redirect_to giveaways_path, notice: '删除成功' }
      format.json { head :no_content }
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
