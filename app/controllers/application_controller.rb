class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception

  def date_from_params date
    DateTime.new(date['date(1i)'].to_i, date['date(2i)'].to_i, date['date(3i)'].to_i)
  end

  def authenticate
    redirect_to login_path unless current_user
  end

  helper_method :current_user
  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end
end
