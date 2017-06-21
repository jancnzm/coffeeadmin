class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def check_login
    if session[:login] == nil || session == ''
      redirect_to logins_path
    end
  end

  def send_pay_success(touser,template_id,url,topcolor,data)
    #debugger
    $client ||= WeixinAuthorize::Client.new("wx5726c31c9832f709", "444f198211e994eb81fb13b9cd4850a2")
    $client.send_template_msg(touser, template_id, url, topcolor, data)
  end



end
