class CountsController < ApplicationController
  skip_before_action :verify_authenticity_token, :only => [:mapscount]
  def index

  end

  class Provincesales
    attr :beijing,true
    attr :tianjin,true
    attr :shanghai,true
    attr :chongqing,true
    attr :hebei,true
    attr :henan,true
    attr :yunnan,true
    attr :liaoning,true
    attr :heilongjiang,true
    attr :hunan,true
    attr :anhui,true
    attr :shandong,true
    attr :xinjiang,true
    attr :jiangsu,true
    attr :zhejiang,true
    attr :jiangxi,true
    attr :hubei,true
    attr :guangxi,true
    attr :gansu,true
    attr :shanxi,true
    attr :neimenggu,true
    attr :shangxi,true#陕西
    attr :jilin,true
    attr :fujian,true
    attr :guizhou,true
    attr :guangdong,true
    attr :qinghai,true
    attr :xizang,true
    attr :sichuan,true
    attr :ningxia,true
    attr :hainan,true
    attr :taiwan,true
    attr :xianggang,true
    attr :aomen,true
  end
  def mapscount
    salestarr = Array.new
    maxvalue = 0

    jinglandgt = Dgt.where('name like ?','%景兰%').first
    hougudgt = Dgt.where('name like ?','%后谷%').first
    step =0
    2.times do
      step += 1
      if step == 1
        products = jinglandgt.products.ids
      else
        products = hougudgt.products.ids
      end
      provincesales=Provincesales.new

      busines = Busine.where('province like ?','%北京%').ids
      provincesales.beijing = Order.where('busine_id in (?) and status =? and product_id in (?)',busines,1,products).sum('paymentamount')
      busines = Busine.where('province like ?','%天津%').ids
      provincesales.tianjin = Order.where('busine_id in (?) and status =? and product_id in (?)',busines,1,products).sum('paymentamount')
      busines = Busine.where('province like ?','%上海%').ids
      provincesales.shanghai = Order.where('busine_id in (?) and status =? and product_id in (?)',busines,1,products).sum('paymentamount')
      busines = Busine.where('province like ?','%重庆%').ids
      provincesales.chongqing = Order.where('busine_id in (?) and status =? and product_id in (?)',busines,1,products).sum('paymentamount')
      busines = Busine.where('province like ?','%河北%').ids
      provincesales.hebei = Order.where('busine_id in (?) and status =? and product_id in (?)',busines,1,products).sum('paymentamount')
      busines = Busine.where('province like ?','%河南%').ids
      provincesales.henan = Order.where('busine_id in (?) and status =? and product_id in (?)',busines,1,products).sum('paymentamount')
      busines = Busine.where('province like ?','%云南%').ids
      provincesales.yunnan = Order.where('busine_id in (?) and status =? and product_id in (?)',busines,1,products).sum('paymentamount')
      busines = Busine.where('province like ?','%辽宁%').ids
      provincesales.liaoning = Order.where('busine_id in (?) and status =? and product_id in (?)',busines,1,products).sum('paymentamount')
      busines = Busine.where('province like ?','%黑龙江%').ids
      provincesales.heilongjiang = Order.where('busine_id in (?) and status =? and product_id in (?)',busines,1,products).sum('paymentamount')
      busines = Busine.where('province like ?','%湖南%').ids
      provincesales.hunan = Order.where('busine_id in (?) and status =? and product_id in (?)',busines,1,products).sum('paymentamount')
      busines = Busine.where('province like ?','%安徽%').ids
      provincesales.anhui = Order.where('busine_id in (?) and status =? and product_id in (?)',busines,1,products).sum('paymentamount')
      busines = Busine.where('province like ?','%山东%').ids
      provincesales.shandong = Order.where('busine_id in (?) and status =? and product_id in (?)',busines,1,products).sum('paymentamount')
      busines = Busine.where('province like ?','%新疆%').ids
      provincesales.xinjiang = Order.where('busine_id in (?) and status =? and product_id in (?)',busines,1,products).sum('paymentamount')
      busines = Busine.where('province like ?','%江苏%').ids
      provincesales.jiangsu = Order.where('busine_id in (?) and status =? and product_id in (?)',busines,1,products).sum('paymentamount')
      busines = Busine.where('province like ?','%浙江%').ids
      provincesales.zhejiang = Order.where('busine_id in (?) and status =? and product_id in (?)',busines,1,products).sum('paymentamount')
      busines = Busine.where('province like ?','%江西%').ids
      provincesales.jiangxi = Order.where('busine_id in (?) and status =? and product_id in (?)',busines,1,products).sum('paymentamount')
      busines = Busine.where('province like ?','%湖北%').ids
      provincesales.hubei = Order.where('busine_id in (?) and status =? and product_id in (?)',busines,1,products).sum('paymentamount')
      busines = Busine.where('province like ?','%广西%').ids
      provincesales.guangxi = Order.where('busine_id in (?) and status =? and product_id in (?)',busines,1,products).sum('paymentamount')
      busines = Busine.where('province like ?','%甘肃%').ids
      provincesales.gansu = Order.where('busine_id in (?) and status =? and product_id in (?)',busines,1,products).sum('paymentamount')
      busines = Busine.where('province like ?','%山西%').ids
      provincesales.shanxi = Order.where('busine_id in (?) and status =? and product_id in (?)',busines,1,products).sum('paymentamount')
      busines = Busine.where('province like ?','%内蒙古%').ids
      provincesales.neimenggu = Order.where('busine_id in (?) and status =? and product_id in (?)',busines,1,products).sum('paymentamount')
      busines = Busine.where('province like ?','%陕西%').ids
      provincesales.shangxi = Order.where('busine_id in (?) and status =? and product_id in (?)',busines,1,products).sum('paymentamount')
      busines = Busine.where('province like ?','%吉林%').ids
      provincesales.jilin = Order.where('busine_id in (?) and status =? and product_id in (?)',busines,1,products).sum('paymentamount')
      busines = Busine.where('province like ?','%福建%').ids
      provincesales.fujian = Order.where('busine_id in (?) and status =? and product_id in (?)',busines,1,products).sum('paymentamount')
      busines = Busine.where('province like ?','%贵州%').ids
      provincesales.guizhou = Order.where('busine_id in (?) and status =? and product_id in (?)',busines,1,products).sum('paymentamount')
      busines = Busine.where('province like ?','%广东%').ids
      provincesales.guangdong = Order.where('busine_id in (?) and status =? and product_id in (?)',busines,1,products).sum('paymentamount')
      busines = Busine.where('province like ?','%青海%').ids
      provincesales.qinghai = Order.where('busine_id in (?) and status =? and product_id in (?)',busines,1,products).sum('paymentamount')
      busines = Busine.where('province like ?','%西藏%').ids
      provincesales.xizang = Order.where('busine_id in (?) and status =? and product_id in (?)',busines,1,products).sum('paymentamount')
      busines = Busine.where('province like ?','%四川%').ids
      provincesales.sichuan = Order.where('busine_id in (?) and status =? and product_id in (?)',busines,1,products).sum('paymentamount')
      busines = Busine.where('province like ?','%宁夏%').ids
      provincesales.ningxia = Order.where('busine_id in (?) and status =? and product_id in (?)',busines,1,products).sum('paymentamount')
      busines = Busine.where('province like ?','%海南%').ids
      provincesales.hainan = Order.where('busine_id in (?) and status =? and product_id in (?)',busines,1,products).sum('paymentamount')
      busines = Busine.where('province like ?','%台湾%').ids
      provincesales.taiwan = Order.where('busine_id in (?) and status =? and product_id in (?)',busines,1,products).sum('paymentamount')
      busines = Busine.where('province like ?','%香港%').ids
      provincesales.xianggang = Order.where('busine_id in (?) and status =? and product_id in (?)',busines,1,products).sum('paymentamount')
      busines = Busine.where('province like ?','%澳门%').ids
      provincesales.aomen = Order.where('busine_id in (?) and status =? and product_id in (?)',busines,1,products).sum('paymentamount')
      salestarr.push provincesales
      temmax = [provincesales.beijing,provincesales.tianjin,provincesales.shanghai,provincesales.chongqing,provincesales.hebei,provincesales.henan,provincesales.yunnan,provincesales.liaoning,provincesales.heilongjiang,provincesales.hunan,provincesales.anhui,provincesales.shandong,provincesales.xinjiang,provincesales.jiangsu,provincesales.zhejiang,provincesales.jiangxi,provincesales.hubei,provincesales.guangxi,provincesales.gansu,provincesales.shanxi,provincesales.neimenggu,provincesales.shangxi,provincesales.jilin,provincesales.fujian,provincesales.guizhou,provincesales.guangdong,provincesales.qinghai,provincesales.xizang,provincesales.sichuan,provincesales.ningxia,provincesales.hainan,provincesales.taiwan,provincesales.xianggang,provincesales.aomen].max
      if temmax > maxvalue
        maxvalue = temmax
      end
    end
    render json: params[:callback]+'({"jinglan":'+salestarr[0].to_json+',"hougu":'+salestarr[1].to_json+',"max":'+maxvalue.to_json+'})',content_type: "application/javascript"
  end

end
