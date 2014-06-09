class SessionsController < ApplicationController
  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path
    else
      render 'new'
    end
  end

  def destroy
    reset_session
    redirect_to login_path
  end
end
