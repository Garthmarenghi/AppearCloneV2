class SessionsController < ApplicationController
  before_action :ensure_authenticated, only: :destroy
  
  def new
  end

  def create
    user = User.find_by(email: params[:email].downcase)

    if(user.present? && user.authenticate(params[:password]))
      session[:user_id] = user.id
      redirect_to new_checkin_path
    else
      flash[:alert] = "Email or password were invalid"
      render 'new'
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to home_about_path
  end
end
