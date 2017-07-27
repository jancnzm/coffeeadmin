class CalcommissionsController < ApplicationController
  def index

    users=User.all

    users.each do |user|
      childrens = user.childrens
      childrens.each do |child|
        amount = 0
        pacts = child.pacts.where('begindate <= ? and enddate >= ?',Time.now,Time.now)
        pacts.each do |pact|
          buycars = Order.where('busine_id = ? and status = ?',pact.busine_id,1)
          amount += buycars.sum('paymentamount')
        end
        if amount > 0
          parent = User.find(child.id).parent

          if parent
            useramounts = parent.useramounts
            useramounts.create(amount:amount * 0.02,content:'管理提成')
            #parent.balance=parent.balance.to_f + amount * 0.02
            #parent.save
          end
#debugger

          commissions = user.commissions
          #commissions.create(commission:amount * 0.02)
          #Profit.create(dgt:'支付管理利润',product:'',number:0,profit:-amount * 0.02)
        end
      end
    end




    render json: params[:callback]+'({"salesman":' + salesmanarr.to_json + '})',content_type: "application/javascript"
  end
end
