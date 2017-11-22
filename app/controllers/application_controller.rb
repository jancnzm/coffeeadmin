class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def check_login
    if session[:login] == nil || session == ''
      redirect_to logins_path
    end
  end

  def send_pay_success(touser,template_id,url,topcolor,data)
    #debugger
    $client ||= WeixinAuthorize::Client.new("wx5726c31c9832f709", "444f198211e994eb81fb13b9cd4850a2")
    $client.send_template_msg(touser, template_id, url, topcolor, data)
  end

  def activity(buycarorder)
    giveaway = Giveaway.where('enable= ? and begindate <= ? and enddate >= ?', 1,Time.now,Time.now)
    giveaway.each do |give|
      buycar=Buycar.find_by_ordernumber(buycarorder)
      giveawayproducts=give.giveawayproducts
      giveproductarr = Array.new
      giveawayproducts.each do |giveawayproduct|
        giveproductarr.push giveawayproduct.product_id
      end
      buycount = 0
      orders=buycar.orders.where('product_id in (?)',giveproductarr)
      buycount = orders.sum('number')

        if buycount >= give.buynum
          if give.once == 1
            giveawaybusines = give.giveawaybusines.where('busine_id = ?', orders.first.busine_id)
            if giveawaybusines.count == 0
              giveorder = orders.create(busine_id:orders.first.busine_id, paymentamount:0, status:1, remark:'', name:orders.first.name, phone:orders.first.phone, address:orders.first.address, number:give.givenum, product_id:give.giveproduct_id)

              giveawaybusines.create(busine_id:orders.first.busine_id,times:1)
              dgt=Product.find(giveorder.product_id).dgt
              profitdgt=dgt.name
              product=Product.find(giveorder.product_id)
              profitproduct=product.name+'（赠送）'
              profit= -product.dgtpro
              Profit.create(dgt:profitdgt,product:profitproduct,number:give.givenum,profit:profit)
              dgtfee=dgt.dgtfees
              dgtfee.create(amount:product.dgtpro)
            end
          else
            giveorder = orders.create(busine_id:orders.first.busine_id, paymentamount:0, status:1, remark:'', name:orders.first.name, phone:orders.first.phone, address:orders.first.address, number:give.givenum, product_id:give.giveproduct_id)
            giveawaybusine = giveawaybusines.where('busine_id = ?',orders.first.busine_id)
            if giveawaybusine.count == 0
              giveawaybusines.create(busine_id:orders.first.busine_id,times:1)
            else
              giveawaybusine.first.times = giveawaybusine.first.times + 1
              giveawaybusine.save
            end
            dgt=Product.find(giveorder.product_id).dgt
            profitdgt=dgt.name
            product=Product.find(giveorder.product_id)
            profitproduct=product.name+'（赠送）'
            profit= -product.dgtpro
            Profit.create(dgt:profitdgt,product:profitproduct,number:give.givenum,profit:profit)
            dgtfee=dgt.dgtfees
            dgtfee.create(amount:product.dgtpro)
          end
        end

    end
  end

  def attchproduct(buycarorder)
    buycar=Buycar.find_by_ordernumber(buycarorder)
    orders=buycar.orders
    attchorders=buycar.attchorders
    jinglanstatus = false
    orders.each do |order|
      product=Product.find(order.product_id)
      dgt=product.dgt
      #dgt=Dgt.products.where('id =?',order.product_id)

      if dgt.name.include?'景兰'
        jinglanstatus = true
      end
    end
    if jinglanstatus
      attchproducts = Attchproduct.where('busine_id = ?',orders.first.busine_id)
        attchproducts.each do |attchproduct|
          if attchproduct.status == 0
            attchorders.create(name:attchproduct.name,number:attchproduct.number,flag:attchproduct.flag)
            attchproduct.status = 1
            attchproduct.save
          end
        end
    end
  end

  def commission(amount,userid)
    parent = User.find(userid).parent
    if parent
      commissions = parent.commissions
      commissions.create(commission:amount*0.02)
      parent.balance=parent.balance.to_f + amount * 0.02
      parent.save
      useramounts = parent.useramounts
      useramounts.create(amount:amount * 0.02,content:'管理提成')

      Profit.create(dgt:'支付管理利润',product:'',number:0,profit:-amount * 0.02)
    end
  end

  def paytoenterprise(buycarorder)

  end



end
