class DgtordersController < ApplicationController
  before_action :set_buycar, only: [:show, :edit, :update, :destroy]
def index

  @buycars=Buycar.where('status != 0 and amount >0').paginate(:page => params[:page], :per_page => 20).order("id desc")
  if session[:dgtid].to_i >0
    dgt=Dgt.find(session[:dgtid])
    products=dgt.products
    productsarr=Array.new
    products.each do |product|
      productsarr.push product.id
    end
    orders=Order.where('product_id in (?)',productsarr)
    ordersarr=Array.new
    orders.each do |order|
      ordersarr.push order.buycar_id
    end
    ordersarr.uniq!
    @buycars=Buycar.where('id in (?) and status !=0 and amount >0',ordersarr).paginate(:page => params[:page], :per_page => 20).order("id desc")

  end
  @busines=Busine.all
end

  def edit
    #debugger
    @buycar=Buycar.find(params[:id])
    @dgts=Dgt.all
    @delives=Delive.all

    order=@buycar.orders.first
         busine=Busine.find(order.busine_id)
    pacts=busine.pacts.where('begindate <=? and enddate >= ?',@buycar.created_at,@buycar.created_at)
    if pacts.count > 0
    @user=pacts.first.user
    end
    #debugger
    #busine=@buycar.busine
    #debugger
    #pacts=busine.pact
    @attchorders=@buycar.attchorders

    if session[:dgtid].to_i>0
      @deliveorders=@buycar.deliveorders.where('dgt_id=?',session[:dgtid])

    else
      @deliveorders=@buycar.deliveorders
    end

  end

  def print
    @buycar=Buycar.find(params[:id])
    @dgts=Dgt.all
    @delives=Delive.all

    order=@buycar.orders.first
    busine=Busine.find(order.busine_id)
    pacts=busine.pacts.where('begindate <=? and enddate >= ?',@buycar.created_at,@buycar.created_at)
    if pacts.count > 0
      @user=pacts.first.user
    end
    #debugger
    #busine=@buycar.busine
    #debugger
    #pacts=busine.pact
    @attchorders=@buycar.attchorders

    if session[:dgtid].to_i>0
      @deliveorders=@buycar.deliveorders.where('dgt_id=?',session[:dgtid])

    else
      @deliveorders=@buycar.deliveorders
    end
  end

def update
  respond_to do |format|
    if @buycar.update(buycar_params)
      format.html { redirect_to dgtorders_path, notice: 'Product was successfully updated.' }
      format.json { render :show, status: :ok, location: @buycar }
    else
      format.html { render :edit }
      format.json { render json: @buycar.errors, status: :unprocessable_entity }
    end
  end
end

def destroy
  @buycar.destroy
  respond_to do |format|
    format.html { redirect_to dgtorders_path, notice: '删除成功' }
    format.json { head :no_content }
  end
end

  def sends
    #debugger
    buycar=Buycar.find(params[:buycarid])
    delive= Delive.find(params[:delive]).delive
    ordernumber=params[:ordernumber]
    deliveorders=Buycar.find(params[:buycarid]).deliveorders
    # if deliveorders.count > 0
    #   deliveorders.first.destroy
    # end
    deliveorders.create(delive:delive,dgt_id:session[:dgtid],ordernumber:ordernumber)
dgt =Dgt.find(session[:dgtid])

    touser=buycar.openid
    template_id='B11kiFyQkMIIsDwjHrmzUesUXpyjQ35dKQYdo3e1E3w'
    url='http://weixin.qq.com/download'
    topcolor='#173177'
    data={
        "first": {
            "value":"您好，您的订单已发货",
            "color":"#173177"
        },
        "keyword1": {
            "value":buycar.ordernumber
        },
        "keyword2":{
            "value":deliveorders.first.delive
        },
        "keyword3": {
            "value":deliveorders.first.ordernumber
        },
        "remark":{
            "value":dgt.name
        }
    }
    debugger
    #send_pay_success(touser,template_id,url,topcolor,data)#厂家发货订单消息


    render json: '{"status":"1"}'
    #redirect_to dgtorders_path
  end

  def deldeliveorders
    deliveorder=Deliveorder.find(params[:format])
    deliveorder.destroy

  end

  def setinvoicestatus
    @buycar=Buycar.find(params[:busineid])
      @buycar.invoicestatus = params[:status].to_i
    @buycar.save

    render json: '{"status":"1"}'
  end

private
# Use callbacks to share common setup or constraints between actions.
def set_buycar
  @buycar = Buycar.find(params[:id])
end

# Never trust parameters from the scary internet, only allow the white list through.
def buycar_params
  params.require(:buycar).permit(:ordernumber ,:name, :phone, :address, :remark, :amount, :openid)
end

end
