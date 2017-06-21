class UseramountsController < ApplicationController

  def index
user=User.find(params[:user_id])
    @useramounts=user.useramounts.order('id desc')
  end

end
