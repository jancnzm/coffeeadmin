class ApisController < ApplicationController
  skip_before_action :verify_authenticity_token, :only => [:idfont,:idback,:attchment]
  def registeruser
    #code 200 正常 201 用户名已存在 202注册中 203无效的邀请码
    code=200
    invitecode =Invitecode.where('code = ? and status =? and invalidtime >?',params[:invitecode],1,Time.now)

    user=User.find(params[:userid])
    hasuser=User.find_by_login(params[:login])
    if hasuser && hasuser.login == params[:login]
      code=201
    elsif invitecode.count > 0
      upuser = invitecode.first.user
      invitecode.first.status = 0
      invitecode.first.save
      user.username=params[:username]
      user.login=params[:login]
      user.password=params[:password]
      user.password_confirmation=params[:password]
      user.isnew=0
      user.balance=0
      user.status=1
      user.up_id = upuser.id
      user.save
    else
      code = 203
    end
    #debugger
    render json: params[:callback]+'({"code":"'+code.to_s+'",user:"'+user.id.to_s+'"})',content_type: "application/javascript"
  end

  def login
    code = 200
    #code 200 正常 201 不存在 202 等待审核 203 停用
    user = User.find_by(login: params[:login]).try(:authenticate, params[:password])
    if user
      if user.status == -1
        code = 202
      elsif user.status == 0
        code =203
      end
      if params[:openid] != ''
        user.openid = params[:openid]
        user.save
      end
      withdraw = user.withdraws
    else
      code=201
    end
    render json: params[:callback]+'({"code":"'+code.to_s+'",user:'+user.to_json+',withdraw:'+withdraw.to_json+'})',content_type: "application/javascript"
  end

  def pactnumber
    pactnumber=DateTime.parse(Time.now.to_s).strftime('%Y%m%d').to_s+params[:userid]+"00"
    #debugger
    pacts=User.find(params[:userid]).pacts
    if pacts.count!=0
      pactnumbertem=pacts.last.number
      if pactnumbertem[0,8] == pactnumber[0,8]
        pactnumber=pactnumbertem
      end
    end

    pactnumber=pactnumber.to_i+1
    #debugger
    render json: params[:callback]+'({"pactnumber":'+pactnumber.to_s.to_json+'})',content_type: "application/javascript"
    #debugger
  end

  def idfont
    user =User.find(params[:userid])
    user.idfontimg=params[:idfont]
    user.save
  end

  def idback
    user =User.find(params[:userid])
    user.idbackimg=params[:idback]
    user.save
  end

  def uploader
    debugger
  end

  def attchment
    attchments=Pact.find(params[:pactid]).attchments
    attchments.create(attchmentimg:params[:attch])

    #attchment.save
    status=200
    render json: status.to_json
#debugger
  end

  class Attch
    attr :id,true
    attr :attchment ,true

  end

  def getattchment
    attchment =Attchment.where("pact_id=?",params[:pactid])
    attarr=Array.new
    attchment.each do|f|
      myattch=Attch.new
      myattch.id=f.id
      myattch.attchment=f.attchmentimg.url
      attarr.push(myattch)
    end

    render json:params[:callback]+'('+attarr.to_json+')',content_type: "application/javascript"
  end

  def registerready
    user = User.new(password:'123',password_confirmation:'123',isnew:1)
    user.save
    #debugger
    render json: params[:callback]+'({"userid":"'+user.id.to_s+'"})',content_type: "application/javascript"
  end

  def deleteattch
    attchment=Attchment.where("id=?",params[:id])
    if attchment.count>0
      attchment.each do |f|
        f.destroy
        #f.save
      end
    end
    render json: params[:callback]+'({"status":"200"})',content_type: "application/javascript"
  end

  def pact
    busine=Busine.create(name:params[:bussname],address:params[:bussaddress],province:params[:province],city:params[:city],districe:params[:district],contact:params[:contact],contactphone:params[:contactphone],buessphone:params[:bussphone])
    busineatts = busine.busineatts
    if params[:tuopan].to_i > 0
      busineatts.create(taobei:params[:taobei],tuopan:params[:toupan],type:0)
    end
    pact=Pact.create(busine_id:busine.id,user_id:params[:userid],number:params[:pactnumber],begindate:DateTime.parse(params[:begindate]),enddate:DateTime.parse(params[:enddate]),status:-1)
    attchproducts=pact.attchproducts
    if params[:taobei].to_i >0
      attchproducts.create(name:'套杯',number:params[:taobei].to_i,flag:'jinglan',status:0, busine_id:busine.id)
    end
    if params[:tuopan].to_i >0
      attchproducts.create(name:'竹托盘',number:params[:tuopan].to_i,flag:'jinglan',status:0, busine_id:busine.id)
    end

    render json: params[:callback]+'({"pactid":'+pact.id.to_s+'})',content_type: "application/javascript"
  end

  def getseller
    if params[:openid]
      if params[:openid]!=''
        $client ||= WeixinAuthorize::Client.new("wx5726c31c9832f709", "444f198211e994eb81fb13b9cd4850a2")
        user_info = $client.user(params[:openid])
        wxuser=Wxuser.find_by_openid(params[:openid])
        if !wxuser
          result=user_info.result
          address=result['province'].to_s+' '+result['city'].to_s
          Wxuser.create(openid:result['openid'],nickname:result['nickname'],sex:result['sex'].to_i,address:address,headimgurl:result['headimgurl'],dgt_id:0,receipt:0)
        end
      end
    end
    busine=Busine.all.order('id desc')
    render json: params[:callback]+'({"seller":' + busine.to_json + '})',content_type: "application/javascript"
  end

  class Mypact
    attr :id,true
    attr :name,true
    attr :address,true
    attr :pactnumber,true
    attr :begindate,true
    attr :enddate,true
    attr :contact,true
    attr :contactphone,true
    attr :paycount,true
  end

  def mypact
    pacts=User.find(params[:userid]).pacts.order('id desc')
    pactarr=Array.new
    pacts.each do |f|
      selfpact=Mypact.new
      selfpact.id=f.id
      busine=Busine.find(f.busine_id)
      selfpact.name=busine.name
      selfpact.address=busine.address
      selfpact.pactnumber=f.number
      selfpact.begindate=f.begindate.strftime('%Y-%m-%d')
      selfpact.enddate=f.enddate.strftime('%Y-%m-%d')
      selfpact.contact=busine.contact
      selfpact.contactphone=busine.contactphone
      paycount=0
      orders=Order.where("busine_id=? and updated_at>=? and updated_at<? and status = ?",busine.id,f.begindate,f.enddate,1)
      paycount = orders.sum('paymentamount')
      selfpact.paycount=paycount
      pactarr.push(selfpact)
    end
    render json: params[:callback]+'({"mypact":' + pactarr.to_json + '})',content_type: "application/javascript"
  end


  def getopenid

    code=params[:code]
    conn = Faraday.new(:url => 'https://api.weixin.qq.com') do |faraday|
      faraday.request :url_encoded # form-encode POST params
      faraday.response :logger # log requests to STDOUT
      faraday.adapter Faraday.default_adapter # make requests with Net::HTTP
    end
    # conn.headers[:apikey] = '6e1802f8c0cd1b42b32249ba42c2e602'
    conn.params[:appid]='wx5726c31c9832f709'
    conn.params[:secret]='444f198211e994eb81fb13b9cd4850a2'
    conn.params[:code]=params[:code]
    conn.params[:grant_type]='authorization_code'
    request = conn.get do |req|
      req.url '/sns/oauth2/access_token'
    end
    #return request.body

    #//////////////////////////////////////////////////////////
    #location = getip(params[:ip])
    accessjson = request.body.to_json
    accesstoken=accessjson['access_token']
    openid=accessjson['openid']
    refreshtoken=accessjson['REFRESH_TOKEN']

    conn = Faraday.new(:url => 'https://api.weixin.qq.com') do |faraday|
      faraday.request :url_encoded # form-encode POST params
      faraday.response :logger # log requests to STDOUT
      faraday.adapter Faraday.default_adapter # make requests with Net::HTTP
    end
    # conn.headers[:apikey] = '6e1802f8c0cd1b42b32249ba42c2e602'
    conn.params[:access_token]=accesstoken
    conn.params[:openid]=openid
    conn.params[:lang]='zh_CN'
    request = conn.get do |req|
      req.url '/sns/userinfo'
    end

    userinfojson=request.body.to_json


    render json: params[:callback]+'({"access_token":' + accessjson + '})',content_type: "application/javascript"
#debugger

#///////////////////////////////////////////////////////

#debugger
  end

  def getpartid
    #status 200 正常 201已存在
    part=Pact.where('number=?',params[:partid])
    if part.count>0
      render json: params[:callback]+'({"status":"201"})',content_type: "application/javascript"
    else
      render json: params[:callback]+'({"status":"200"})',content_type: "application/javascript"
    end
  end

  def getbuinesname
    busine=Busine.where('name=?',params[:businename])
    if busine.count>0
      render json: params[:callback]+'({"status":"201"})',content_type: "application/javascript"
    else
      render json: params[:callback]+'({"status":"200"})',content_type: "application/javascript"
    end
  end

  class Productarr
    attr :id,true
    attr :dgt_id,true
    attr :name,true
    attr :unit,true
    attr :price,true
    attr :detail,true
    attr :spec,true
    attr :productimg,true

  end

  def getproduct
    products=Product.all.order("id desc")
    productarr =Array.new
    products.each do |product|
      pro=Productarr.new
      pro.id=product.id
      pro.dgt_id=product.dgt_id
      pro.name=product.name
      pro.unit=product.unit
      pro.price=product.price
      pro.detail=product.detail
      pro.spec=product.spec
      pro.productimg=product.productimg
      productarr.push(pro)
    end
    render json: params[:callback]+'({"product":' + productarr.to_json + '})',content_type: "application/javascript"
  end

  #检查是否设置提现密码
  def checkpwd
    userpwd =User.find(params[:userid]).userpwds
    if userpwd.count>0
      render json: params[:callback]+'({"status":"1"})',content_type: "application/javascript"
    else
      render json: params[:callback]+'({"status":"0"})',content_type: "application/javascript"
    end

  end

  def setpwd
    userpwd =User.find(params[:userid]).userpwds
    userpwd.each do |f|
      f.destroy
    end
    userpwd.create(password_confirmation:params[:pwd], password:params[:pwd])
    render json: params[:callback]+'({"status":"1"})',content_type: "application/javascript"
  end

  def authpwd
    userpwd=User.find(params[:userid]).userpwds
    if userpwd.first.authenticate(params[:pwd])
      render json: params[:callback]+'({"status":"1"})',content_type: "application/javascript"
    else
      render json: params[:callback]+'({"status":"0"})',content_type: "application/javascript"
    end
  end

  class Deviveryorder
    attr :busine,true
    attr :name,true
    attr :phone,true
    attr :address,true
    attr :remark,true
  end

  def getdevivery
    buycar=Buycar.find(params[:buycarid])
    dgtid=params[:dgtid]
    orders=buycar.orders
    orders.each do |f|

    end

  end

  def test

    touser='omi6rv4L1PpGVzXZ6bguxvCmQGz8'
    template_id='Us_mRiu93r0uDFVG3T3VDcR1bwSB--AzOCTXrp-7hqA'
    url='http://weixin.qq.com/download'
    topcolor='#173177'
    data={
        "first": {
            "value":"您好，您有新的开票通知",
            "color":"#173177"
        },
        "keyword1": {
            "value":'201705251519199'
        },
        "keyword2":{
            "value":'2017-5-4 11:30:18'
        },
        "remark":{
            "value":'开票商家：玉溪龙马酒店'
        }
    }
    send_pay_success(touser,template_id,url,topcolor,data)#厂家发货订单消息
  end

  class Pactbusine
    attr :busine,true
    attr :buycars,true
  end


  def getcurrentseller
    busine = Busine.find(params[:busineid])
    pact = busine.pacts.order('id desc').first
    orders = Order.where('busine_id = ?', params[:busineid])
    buycar_id_arr = Array.new
    orders.each do |order|
      if order.created_at >= pact.begindate && order.created_at <= pact.enddate
        buycar = order.buycar
        if buycar.status == 1
          buycar_id_arr.push buycar.id
        end
      end
    end
    buycar_id_arr.uniq!
    buycararr = Array.new
    buycar_id_arr.each do |buycarid|
      buycar = Buycar.find(buycarid)
      buycararr.push buycar
    end
    pactbusine = Pactbusine.new
    pactbusine.busine = busine
    pactbusine.buycars = buycararr
    render json:params[:callback]+'('+pactbusine.to_json+')',content_type: "application/javascript"
  end

  def getinvitecode
    invalidcode = Invitecode.where('invalidtime < ?',Time.now)
    invalidcode.each do |delcode|
      delcode.destroy
    end
    if params[:userid]
      singlecode=''
      8.times do |f|
        singlecode +=rand(10).to_s
      end
      newcode = Invitecode.where('code = ?',singlecode)
      if newcode.count >0
        getinvitecode
      else
        user=User.find(params[:userid])
        invitecodes =user.invitecodes
        invitecodes.create(code:singlecode,status:1,invalidtime:Time.now + 1.days)
      end
    end
    invitecodes=User.find(params[:userid]).invitecodes
    render json: params[:callback]+'({"invitecode":' + invitecodes.to_json + '})',content_type: "application/javascript"
  end

  def myinvitecode
    invitecodes=User.find(params[:userid]).invitecodes.where('invalidtime > ?',Time.now)
    render json: params[:callback]+'({"invitecode":' + invitecodes.to_json + '})',content_type: "application/javascript"
  end

  class Salesmanclass
    attr :name,true
    attr :amount,true
    attr :profit,true
  end
  def getsalesman
    childrens = User.find(params[:userid]).childrens
    salesmanarr = Array.new
    childrens.each do |child|
      salesman = Salesmanclass.new
      salesman.name = child.username
      amount = 0
      pacts = child.pacts.where('begindate <= ? and enddate >= ?',Time.now,Time.now)
      pacts.each do |pact|
        buycars = Order.where('busine_id = ? and status = ?',pact.busine_id,1)
        amount += buycars.sum('paymentamount')
      end
      salesman.amount = amount
      salesman.profit = child.balance
      salesmanarr.push salesman
    end
    render json: params[:callback]+'({"salesman":' + salesmanarr.to_json + '})',content_type: "application/javascript"
  end

  def getup
    parent = User.find(params[:userid]).parent
    code ='无'
    if parent
      code = parent.username
    end
    render json: params[:callback]+'({"code":' + code.to_json + '})',content_type: "application/javascript"
  end

  def getcommission
    user = User.find(params[:userid]).order('id desc')
    commissions = user.commissions
    render json: params[:callback]+'({"commission":' + commissions.to_json + '})',content_type: "application/javascript"
  end

  def checkwithdrawcode
    user=User.find(params[:userid])
    if user.withdrawcode == params[:code] && user.withdrawcodetime + 5.minutes > Time.now
      render json: params[:callback]+'({"status":"1"})',content_type: "application/javascript"
    else
      render json: params[:callback]+'({"status":"0"})',content_type: "application/javascript"
    end
  end

  def sendtest
    wxusers=Array.new
    wxusers.push 'omi6rv6zuFj5cc1t4gd86gaR347U'
    wxusers.push 'omi6rv4L1PpGVzXZ6bguxvCmQGz8'
    wxusers.push 'omi6rv22M6o0lAkoeGlzohvZhlmc'
    step =0
    10.times do
      step +=1
      wxusers.each do |wxuser|
        touser=wxuser
        template_id='Us_mRiu93r0uDFVG3T3VDcR1bwSB--AzOCTXrp-7hqA'
        url='http://weixin.qq.com/download'
        topcolor='#173177'
        data={
            "first": {
                "value":"您有新的订单",
                "color":"#173177"
            },
            "keyword1":{
                "value":'test'
            },
            "keyword2": {
                "value":'test'
            },
            "remark":{
                "value":'这是第'+step.to_s+'条测试信息'
            }
        }
        send_pay_success(touser,template_id,url,topcolor,data)#厂家订单消息
      end
    end
    render json: params[:callback]+'({"status":"1"})',content_type: "application/javascript"
  end






end

