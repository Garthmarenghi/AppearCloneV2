class ApplicationController < ActionController::Base
  before_action :set_locale

  protect_from_forgery with: :exception
  helper_method :logged_in?, :current_user

  def default_url_options
    { locale: I18n.locale }
  end

  def logged_in?
    session[:user_id].present?
  end

  def current_user
    if @current_user.present?
      return @current_user
    end
    @current_user = User.find(session[:user_id])
  end

  def ensure_authenticated
    redirect_to home_about_path unless logged_in?
  end

  def ensure_user_has_at_least_one_checkin
    redirect_to new_checkin_path unless current_user.checkins.any?
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end
