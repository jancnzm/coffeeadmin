class LoginsController < ApplicationController

  def index
    if params[:command]
      session[:login]= nil
      session[:username] = nil
      session[:id]=nil
      session[:dgtid]=nil
    end
  end

  def create

checkadmin=Admin.all
if checkadmin==nil
  Admin.create(username:'系统管理员',login:'admin',password:'posan',password_confirmation:'posan',status:'1',dgt_id:0)
end


    admin = Admin.find_by(login:params[:login][:login])
    if admin && admin.status==0 && admin.authenticate(params[:login][:password])
      redirect_to action: 'index',id:1
    else
      if admin &&  admin.authenticate(params[:login][:password])
        session[:login]= admin.login
        session[:username] = admin.username
        session[:id]=admin.id
        session[:dgtid]=admin.dgt_id
        redirect_to dgtorders_path
      else
        redirect_to action: 'index',id:0
      end
    end
  end

end
