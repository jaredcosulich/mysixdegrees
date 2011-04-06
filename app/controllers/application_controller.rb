class ApplicationController < ActionController::Base
  include RedirectBack
  
  helper_method :resource_class
  protect_from_forgery

  before_filter :set_session_identifier

  def current_user
    super || NilUser.new
  end

  def user_signed_in?
    !current_user.nil?
  end

  def set_session_identifier
    session["identifier"] = Time.new.to_i if session["identifier"].nil?
  end

  def session_identifier
    "#{request.remote_ip}-#{session["identifier"]}"
  end
end
