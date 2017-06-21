class AlipaymentsController < ApplicationController

  def pay
    @partner_id = '2088123456' # 支付宝合作者身份 ID，以 2088 开头
    @key = 'SECURE_KEY' # 安全校验码

    @merchant = ChinaPay::Alipay::Merchant.new(@partner_id, @key)

    @order_id = 'KC201301300001D' # 商家内部唯一订单编号
    @subject = 'iPhone 5 16G 黑色 x 1' # 订单标题
    @description = '感谢您购买 iPhone 5 ！' # 订单内容

    @order = @merchant.create_order(@order_id, @subject, @description)

    @seller_email = 'seller@company.com' # 卖家支付宝帐号
    @total_fee = 0.01 # 订单总额

    @direct_pay = @order.seller_email(@seller_email).total_fee(@total_fee).direct_pay

    # 交易成功同步返回地址
    @return_url = 'http://company.com/payments/success'
    @direct_pay.after_payment_redirect_url(@return_url)

    # 交易状态变更异步通知地址
    @notify_url = 'http://company.com/payments/notify'
    @direct_pay.notification_callback_url(@notify_url)

    redirect_to @direct_pay.gateway_api_url
  end

end
