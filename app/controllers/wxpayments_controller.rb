class WxpaymentsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def information
    fee = params[:fee]
    order_sn = params[:ordersn]
    #Order.create(number:params[:number],busine_id:params[:busineid],ordernumber:order_sn,paymentamount:fee,status:0,remark:params[:remark],linkparams:UUIDTools::UUID.timestamp_create.to_s.gsub('-',''),name:params[:name],phone:params[:phone],address:params[:address],product_id:params[:productid])

    buycar=Buycar.create(ordernumber:order_sn,amount:fee,name:params[:name],phone:params[:phone],address:params[:address],remark:params[:remark],status:0)
    orders=buycar.orders
    number=params[:number].split(':')
    price=params[:price].split(':')
    productid=params[:productid].split(':')
    step=0
    number.each do |f|
      paymentamount=f.to_i * price[step].to_f
      orders.create(busine_id:params[:busineid],paymentamount:paymentamount,status:0,remark:params[:remark],name:params[:name],phone:params[:phone],address:params[:address],number:f.to_i,product_id:productid[step].to_i)
      step=step+1
    end
    payment_params = {
        body: "云南咖啡",
        out_trade_no: order_sn,
        # 单位是 分, 所以要 乘以 100
        #total_fee: (fee.to_f * 100).to_i,

        total_fee: (fee.to_f * 100).to_i,
        # 我们服务器的 IP
        spbill_create_ip:  '127.0.0.1',
        # 微信服务器调用我们服务器的接口
        notify_url: 'http://coffeeadmin.posan.biz/wxpayments/notify',
        trade_type: 'JSAPI', # could be "JSAPI", "NATIVE" or "APP",
        # 用户的open id
        openid: params[:openid]  # required when trade_type is `JSAPI`
    }
    @result = WxPay::Service.invoke_unifiedorder(payment_params)


    $client ||= WeixinAuthorize::Client.new("wx5726c31c9832f709", "444f198211e994eb81fb13b9cd4850a2")

    #followers = $client.followers
    #user_info = $client.user("omi6rv6zuFj5cc1t4gd86gaR347U")
    @sign_package = $client.get_jssign_package(request.url)

    if @result.nil?
      #render html: "no"
    else
      #render html: "#{@result.to_s},#{params.to_s}" if @result['return_code']=='FAIL'
      @pay_ticket_param = {
          timeStamp: @sign_package["timestamp"],
          nonceStr: @sign_package["nonceStr"],
          package: "prepay_id=#{@result['prepay_id']}",  #这里一定注意，不仅仅是prepay_id，还需要拼接上“prepay_id=”
          signType: "MD5",
          appId: WxPay.appid,
          key: WxPay.key
      }
      @pay_ticket_param = {
          paySign: WxPay::Sign.generate(@pay_ticket_param)  #然后我们手动进行paySign计算
      }.merge(@pay_ticket_param)
    end

    #render text: pay_ticket_param
    #render json:params[:callback]+'('+ @result.to_json+')',content_type: "application/javascript"

    render json: params[:callback]+'({"pay_ticket_param":' + @pay_ticket_param.to_json + ',"sign_packge":'+@sign_package.to_json+'})',content_type: "application/javascript"
  end

  # 这个是支付完之后的回调函数.
  def notify
    #Testlog.create(log:'notify')
    result = Hash.from_xml(request.body.read)["xml"]
    if result['return_code']=='SUCCESS'
      profitdgt=''#厂商名称
      profitproduct=''#产品名称
      profitnumber=0#产品数量
      profitprice=0.0#产品单价
      profit=0.0#利润
      profitcost=0.0#成本
      profitbusine=0.0#业务分成
      order_sn=result['out_trade_no']
      buycar=Buycar.find_by_ordernumber(order_sn)
      orders=buycar.orders
      dgt_id_count=Array.new
      userprofitsum=0
      orders.each do |f|
        if f.status ==0
          f.status=1
          f.save
          product=Product.find(f.product_id)
          profitproduct=product.name
          profitprice=product.price
          dgt=product.dgt
          dgt_id_count.push dgt.id
          profitdgt=dgt.name
          dgtfees=dgt.dgtfees
          dgtfees.create(amount:f.number*product.dgtpro)
          profitnumber=f.number
          profitcost=f.number*product.dgtpro
          pact=Pact.where('busine_id=?',f.busine_id)
          pact=pact.where('begindate<=? and enddate>=?',f.created_at,f.created_at)
          pact=pact.first
          if pact != nil
            user=pact.user
            user.balance=user.balance+f.number*product.businepro
            user.save
            useramount=user.useramounts
            useramount.create(amount:f.number*product.businepro,content:'商家购买商品')
            profitbusine=f.number*product.businepro
          end
          profit=profitprice*profitnumber-profitcost-profitbusine
          Profit.create(dgt:profitdgt,product:profitproduct,number:profitnumber,profit:profit)
        end
      end

      buycar.status=1
      buycar.save

      dgt_id_count.uniq!
      wxuser=Wxuser.all
      dgt_id_count.each do |f|
        wxuser.each do |wxuser|
          if wxuser.dgt_id == f
            touser=wxuser.openid
            template_id='Us_mRiu93r0uDFVG3T3VDcR1bwSB--AzOCTXrp-7hqA'
            url='http://weixin.qq.com/download'
            topcolor='#173177'
            data={
                "first": {
                    "value":"您有新的订单",
                    "color":"#173177"
                },
                "keyword1":{
                    "value":buycar.ordernumber
                },
                "keyword2": {
                    "value":buycar.updated_at.strftime('%Y-%m-%d %H:%M:%S')
                },
                "remark":{
                    "value":buycar.remark
                }
            }
            send_pay_success(touser,template_id,url,topcolor,data)#厂家订单消息
          end
        end
      end


      touser=buycar.openid
      template_id='EJ26NpZZxuva6zLWrQMmZS64861_pEmNHtf2Ak8Zkco'
      url='http://weixin.qq.com/download'
      topcolor='#173177'
      data={
          "first": {
              "value":"您好，您的订单已付款成功",
              "color":"#173177"
          },
          "keyword1":{
              "value":buycar.ordernumber
          },
          "keyword2": {
              "value":buycar.updated_at.strftime('%Y-%m-%d %H:%M:%S')
          },
          "keyword3": {
              "value":buycar.amount.to_s+'元'
          },
          "keyword4": {
              "value":"微信支付"
          },
          "remark":{
              "value":"感谢您的惠顾"
          }
      }
      send_pay_success(touser,template_id,url,topcolor,data)#支付成功消息

      render :xml => {return_code: "SUCCESS"}.to_xml(root: 'xml', dasherize: false)
    end
  end

  def payuser
    nonce=SecureRandom.uuid.tr('-', '')
    #nonce='123456789'
    #mykey =WxPay.key
    payment_params={

nonce_str:nonce,
        partner_trade_no:'2017044554433345181207',
        openid:'oU58FxAQdyuhVipFpADlkkMlZUDU',
        check_name:'NO_CHECK',
        amount:100,
        desc:'posan',
        spbill_create_ip:'100.77.128.249'
    }

    #payment_params=payment_params.to_s
    #sign=WxPay::Sign.generate(payment_params)


    @result = WxPay::Service.invoke_transfer(payment_params)
    debugger

  end


end
