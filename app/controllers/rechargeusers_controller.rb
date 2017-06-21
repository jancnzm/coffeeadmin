class RechargeusersController < ApplicationController

  def index

  end

  def new
    @rechargeuser = Useramount.new
  end


  def create
    user=User.find_by_login(params[:login])
    useramounts=user.useramounts
    useramounts.create(amount:params[:amount].to_f,content:params[:content])
    user.balance=user.balance.to_f + (params[:amount].to_f)
    user.save
    profit=Profit.create(dgt:'平台转账到用户',product:'',number:0,profit:-(params[:amount].to_f))
redirect_to users_path
  end

  def getuser
user=User.find_by_login(params[:login])
    if user
      render json:'{"status":"1","username":"'+user.username+'"}'
    else
      render json:'{"status":"0"}'
    end
  end



  private
  # Use callbacks to share common setup or constraints between actions.

  # Never trust parameters from the scary internet, only allow the white list through.
  def rechargeuser_params
    params.require(:useramount).permit(:user_id ,:amount, :content)
  end

end
