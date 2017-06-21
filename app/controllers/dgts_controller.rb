class DgtsController < ApplicationController
  before_action :set_dgt, only: [:show, :edit, :update, :destroy]
  def index
    @dgts=Dgt.all
    @dgtfees=Dgtfee.all
  end

  def edit
    @dgt=Dgt.find(params[:id])

  end

  def new
    @dgt = Dgt.new
  end

  def create
    @dgt = Dgt.new(dgt_params)

    respond_to do |format|
      if @dgt.save
        format.html { redirect_to dgts_path, notice: 'Dgt was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @dgt.update(dgt_params)
        format.html { redirect_to dgts_path, notice: 'Dgt was successfully updated.' }
        format.json { render :show, status: :ok, location: @dgt }
      else
        format.html { render :edit }
        format.json { render json: @dgt.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @dgt.destroy
    respond_to do |format|
      format.html { redirect_to dgts_path, notice: '删除成功' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_dgt
    @dgt = Dgt.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def dgt_params
    params.require(:dgt).permit(:name ,:contact, :phone)
  end

end
