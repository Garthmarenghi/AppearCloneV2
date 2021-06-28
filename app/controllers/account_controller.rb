class AccountController < ApplicationController
  before_action :ensure_authenticated
  before_action :ensure_user_has_at_least_one_checkin

  def edit
  end

  def update
    if(current_user.update(user_params))
      redirect_to account_path
    else
      render 'edit'
    end
  end

  def home
    @checkins = current_user.checkins.most_recent_first.page(params[:page])
    @friends = current_user.friends.sort_by{|user| user.distance_to(current_user)}
    @friend_requests = current_user.pending_my_action
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :avatar, :password)
  end

end
