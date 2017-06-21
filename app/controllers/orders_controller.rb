class OrdersController < ApplicationController
  before_action :check_login
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  def index
    if session[:dgtid].to_i >0
      products=Dgt.find(session[:dgtid]).products
      productsarr =Array.new
      products.each do |product|
        productsarr.push product.id
      end
      @orders=Order.where('product_id in (?)',productsarr).order('id desc')
    else
    @orders=Order.all.order("id desc")
    end
    @busines=Busine.all
    @buycars=Buycar.all
    @products=Product.all
  end

  def edit
    @order=Order.find(params[:id])

  end

  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to orders_path, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_order
    @order = Order.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def order_params
    params.require(:order).permit(:busine_id ,:ordernumber, :paymentamount,:status,:remark,:linkparams,:name,:phone, :address)
  end

end
