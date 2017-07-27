class WithdrawsController < ApplicationController

  def create
    @user = User.find(params[:user_id])
    @withdraws = @user.withdraws.create(withdraw_params)
    redirect_to edit_userinoutcount_path(@user)
  end

  def destroy
    @user = User.find(params[:user_id])
    @withdraws = @user.withdraws.find(params[:id])
    @withdraws.destroy
    redirect_to edit_userinoutcount_path(@user)
  end

  private
  def withdraw_params
    params.require(:withdraw).permit(:withdraw)
  end

end
