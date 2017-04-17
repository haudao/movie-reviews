class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  def prepare_data
    Movie.crawl_data
  end

  def current_user
    return unless session[:user_id]
    @current_user ||= User.find_by_id(session[:user_id])
  end

  helper_method :current_user

  def logged_in?
    current_user.is_a? User
  end

  helper_method :logged_in?
end
