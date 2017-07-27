class GiveawaybusinesController < ApplicationController

  def create
    @giveaway = Giveaway.find(params[:giveaway_id])
    @giveawaybusines = @giveaway.giveawaybusines.create(giveawaybusine_params)
    redirect_to edit_giveaway_path(@giveaway)
  end

  def destroy
    @giveaway = Giveaway.find(params[:giveaway_id])
    @giveawaybusines = @giveaway.giveawaybusines.find(params[:id])
    @giveawaybusines.destroy
    redirect_to edit_giveaway_path(@giveaway)
  end

  private
  def giveawaybusine_params
    params.require(:giveawaybusine).permit(:busine_id, :times)
  end

end
