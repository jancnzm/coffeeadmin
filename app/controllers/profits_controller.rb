class ProfitsController < ApplicationController

  def index
    @profits=Profit.all
  end

end
