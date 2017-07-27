class GiveawayproductsController < ApplicationController

  def create
    @giveaway = Giveaway.find(params[:giveaway_id])
    @giveawayproducts = @giveaway.giveawayproducts.create(giveawayproduct_params)
    redirect_to edit_giveaway_path(@giveaway)
  end

  def destroy
    @giveaway = Giveaway.find(params[:giveaway_id])
    @giveawayproducts = @giveaway.giveawayproducts.find(params[:id])
    @giveawayproducts.destroy
    redirect_to edit_giveaway_path(@giveaway)
  end

  private
  def giveawayproduct_params
    params.require(:giveawayproduct).permit(:product_id)
  end

end
