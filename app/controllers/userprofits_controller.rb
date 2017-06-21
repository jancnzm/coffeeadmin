class UserprofitsController < ApplicationController

  def index
    @useramounts=Useramount.all.order('id desc')
  end

end
