class UsersController < ApplicationController
  before_action :ensure_authenticated,                 only: [:index, :show]
  before_action :ensure_user_has_at_least_one_checkin, only: [:index, :show]
  before_action :load_user,                            only: [:show]
  before_action :ensure_friends,                       only: [:show]

  def index
    @search_term = params[:q]
    @users = User.search(@search_term).page(params[:page])
  end

  def show
    @checkins = @user.checkins.most_recent_first.page(params[:page])
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if(@user.save)
      session[:user_id] = @user.id
      redirect_to new_checkin_path
    else
      render 'new'
    end
  end

  def update
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :name, :avatar, :location)
  end

  def load_user
    @user = User.find(params[:id])
  end

  def ensure_friends
    redirect_to root_path unless current_user.friend_with?(@user)
  end
end
