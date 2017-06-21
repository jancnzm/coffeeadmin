class BusinesController < ApplicationController

  before_action :set_busine, only: [:show, :edit, :update, :destroy]
  def index
    @busines=Busine.all.order("id desc")
  end

  def edit


  end

  def update
    respond_to do |format|
      if @busine.update(busine_params)
        format.html { redirect_to busines_path, notice: 'Busine was successfully updated.' }
        format.json { render :show, status: :ok, location: @busine }
      else
        format.html { render :edit }
        format.json { render json: @busine.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @busine.destroy
    respond_to do |format|
      format.html { redirect_to busines_path, notice: '删除成功' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_busine
    @busine = Busine.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def busine_params
    params.require(:busine).permit(:name ,:address, :province,:city,:districe,:contact,:contactphone,:buessphone)
  end

end
