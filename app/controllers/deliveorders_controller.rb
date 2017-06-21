class DeliveordersController < ApplicationController

  def create
    @buycar = Buycar.find(params[:buycar_id])
    @deliveorders = @buycar.deliveorders.create(deliveorder_params)
dgt=Dgt.find(@deliveorders.dgt_id)
    touser=@buycar.openid
    template_id='B11kiFyQkMIIsDwjHrmzUesUXpyjQ35dKQYdo3e1E3w'
    url='http://weixin.qq.com/download'
    topcolor='#173177'
    data={
        "first": {
            "value":"您好，您的订单已发货",
            "color":"#173177"
        },
        "keyword1": {
            "value":@buycar.ordernumber
        },
        "keyword2":{
            "value":@deliveorders.delive
        },
        "keyword3": {
            "value":@deliveorders.ordernumber
        },
        "remark":{
            "value":dgt.name
        }
    }
    send_pay_success(touser,template_id,url,topcolor,data)#厂家发货订单消息

    redirect_to edit_dgtorder_path(@buycar)
  end

  def destroy
    @buycar = Buycar.find(params[:buycar_id])
    @deliveorders = @buycar.deliveorders.find(params[:id])
    @deliveorders.destroy
    redirect_to edit_dgtorder_path(@buycar)
  end

  private
  def deliveorder_params
    params.require(:deliveorder).permit(:delive, :buycar_id, :dgt_id, :ordernumber)
  end

end
