# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  helper_method :current_user,:current_user?,:login?
  
  def login?
    current_user != nil
  end
  #检查是否登录
  def check_login?
    if (cookies[:auto_login_user_id].nil?)
      if request.xhr?
        redirect_to login_account_path(:js)
      else
        flash[:notice] = "请先登录后才能进行操作"
        redirect_to login_account_path(:reurl=>url_for())
      end
    else
      user=User.real_users.find(cookies[:auto_login_user_id])
      if (user && (auth_text=User.authenticate(user))=="成功")
        return session[:user]=user
      else
        flash.now[:notice] = auth_text
        redirect_to login_account_path()
      end
    end if (session[:user].nil?)
  end

  #获取当前用户
  def current_user
    User.real_users.find(session[:user]) if session[:user]
  end
  #判断是否 当前 用户
  def current_user?(user)
    user && current_user &&   current_user.accounts.include?(user)
  end
 
end
