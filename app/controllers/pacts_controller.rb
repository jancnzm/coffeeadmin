class PactsController < ApplicationController
  before_action :set_pact, only: [:show, :edit, :update, :destroy]
  def index
    @pacts=Pact.all.order('updated_at desc')
    #@busines=Busine.all
    @users=User.all
  end

  def edit


  end

  def update
    respond_to do |format|
      if @pact.update(pact_params)
        format.html { redirect_to pacts_path, notice: 'Pact was successfully updated.' }
        format.json { render :show, status: :ok, location: @pact }
      else
        format.html { render :edit }
        format.json { render json: @pact.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @pact.destroy
    respond_to do |format|
      format.html { redirect_to pacts_path, notice: '删除成功' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_pact
    @pact = Pact.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def pact_params
    params.require(:pact).permit(:busine_id ,:user_id, :number,:begindate,:enddate,:status)
  end

end
