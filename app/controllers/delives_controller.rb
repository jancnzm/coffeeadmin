class DelivesController < ApplicationController

  before_action :set_delive, only: [:show, :edit, :update, :destroy]
  def index
    @delives=Delive.all
  end

  def edit
    @delive=Delive.find(params[:id])

  end

  def new
    @delive = Delive.new
  end

  def create
    @delive = Delive.new(delive_params)

    respond_to do |format|
      if @delive.save
        format.html { redirect_to delives_path, notice: 'Dgt was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @delive.update(delive_params)
        format.html { redirect_to delives_path, notice: 'Dgt was successfully updated.' }
        format.json { render :show, status: :ok, location: @delive }
      else
        format.html { render :edit }
        format.json { render json: @delive.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @delive.destroy
    respond_to do |format|
      format.html { redirect_to delives_path, notice: '删除成功' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_delive
    @delive = Delive.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def delive_params
    params.require(:delive).permit(:delive)
  end

end
