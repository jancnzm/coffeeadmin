class ApisController < ApplicationController
  skip_before_action :verify_authenticity_token, :only => [:idfont,:idback,:attchment]
  def registeruser
    #code 200 正常 201 用户名已存在 202注册中
    code=200
    user=User.find(params[:userid])
    hasuser=User.find_by_login(params[:login])
    if hasuser && hasuser.login == params[:login]
      code=201
    else
      user.username=params[:username]
      user.login=params[:login]
      user.password=params[:password]
      user.password_confirmation=params[:password]
      user.isnew=0
      user.balance=0
      user.status=-1
      user.save
    end
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
    else
      code=201
    end
    render json: params[:callback]+'({"code":"'+code.to_s+'",user:'+user.to_json+'})',content_type: "application/javascript"
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
    pact=Pact.create(busine_id:busine.id,user_id:params[:userid],number:params[:pactnumber],begindate:DateTime.parse(params[:begindate]),enddate:DateTime.parse(params[:enddate]),status:-1)
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
    pacts=User.find(params[:userid]).pacts
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
      orders=Order.where("busine_id=? and updated_at>=? and updated_at<?",busine.id,f.begindate,f.enddate)
      orders.each do |o|
        paycount=paycount+o.paymentamount
      end
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




end

