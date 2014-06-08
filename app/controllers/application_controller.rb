class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception

  def date_from_params date
    DateTime.new(date['date(1i)'].to_i, date['date(2i)'].to_i, date['date(3i)'].to_i)
  end
end
