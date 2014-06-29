# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  session_times_out_in 3600, :before_timeout=> :user_logout

  def timeout_authorize
    redirect_to :controller => "admin", :action=>"login"
  end

  #clear user session
  def user_logout
    session[:user_id]=nil
  end

  private
  def error_messages_of(object)
    ret=[]
    object.errors.each  { |error| text<<['<li>'+error[1].to_s+'</li>']} if object && !object.errors.empty?
    return ret=[]
  end

  #  def log_error(exception)
  #    super Mailer.deliver_error_message(exception,clean_backtrace(exception),session.instance_variable_get("@data"),params,request.env)
  #  end

  def user_authorize
    unless User.user_authorize(session[:user_id])
      flash[:notice] = "请登陆"
      if request.xhr?
        render :update do |page|
          page.redirect_to :controller => "admin", :action=>"login"
        end
      else
        redirect_to :controller => "admin", :action=>"login"
      end
    end
  end

  def admin_authorize
    unless User.admin_authorize(session[:user_id])
      flash[:notice] = "请用管理员登陆"
      if request.xhr?
        render :update do |page|
          page.redirect_to :controller => "admin", :action=>"login"
        end
      else
        redirect_to :controller => "admin", :action=>"login"
      end
    end
  end

end
