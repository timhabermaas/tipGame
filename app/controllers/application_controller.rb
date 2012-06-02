#encoding: utf-8

class ApplicationController < ActionController::Base
  class UnauthorizedException < Exception
  end

  rescue_from UnauthorizedException, :with => :redirect_to_login

  protect_from_forgery

  before_filter :set_time_zone

  helper_method :current_user, :logged_in?, :admin?

protected
  def current_user=(user)
    session[:user_id] = user.try(:id)
    @current_user = user
  end

  def current_user
    return nil unless session[:user_id]
    @current_user ||= User.find session[:user_id]
    @current_user
  end

  def logged_in?
    !current_user.nil?
  end

  def login_required
    unauthorized! if not logged_in?
  end

  def unauthorized!
    raise UnauthorizedException
  end

  def admin?
    current_user.try(:admin?)
  end

  def admin_required
    unless admin?
      action_forbidden_message
      redirect_to root_path
    end
  end

  def action_forbidden_message
    flash[:notice] = "Hier geht's für dich nicht weiter!"
  end

  def set_time_zone
    Time.zone = "Berlin"
  end

  def redirect_to_login
    redirect_to login_path
  end
end
