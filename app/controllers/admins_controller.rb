class AdminsController < ApplicationController
  before_action :check_login
  before_action :set_admin, only: [:show, :edit, :update, :destroy]
  def index
    @admins=Admin.all
    if !@admins
      Admin.create(username:'系统管理员',login:'admin',password:'posan',password_confirmation:'posan',status:'1',dgt_id:0)
    end
    @dgts=Dgt.all
  end

  def edit
    @admin=Admin.find(params[:id])
    @dgts=Dgt.all
  end

  def new
    @admin = Admin.new
    @dgts=Dgt.all
  end

  def create
    @admin = Admin.new(admin_params)

    respond_to do |format|
      if @admin.save
        format.html { redirect_to admins_path, notice: 'Dgt was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @admin.update(admin_params)
        format.html { redirect_to admins_path, notice: 'Dgt was successfully updated.' }
        format.json { render :show, status: :ok, location: @dgt }
      else
        format.html { render :edit }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @admin.destroy
    respond_to do |format|
      format.html { redirect_to admins_path, notice: '删除成功' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_admin
    @admin = Admin.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def admin_params
    params.require(:admin).permit(:username ,:login,:password, :password_confirmation,:dgt_id, :status)
  end

end
