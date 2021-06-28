class CheckinsController < ApplicationController
  before_action :ensure_authenticated
  before_action :ensure_user_has_at_least_one_checkin, only: [:edit, :update, :destroy]
  before_action :load_checkin,                         only: [:edit, :update, :destroy]
  before_action :authorise_to_edit_checkin,            only: [:edit, :update, :destroy]

  def new
    @checkin = Checkin.new
  end

  def edit
  end
  
  def create
    user = User.find(session[:user_id])

    if params[:button] == 'manual'
      @checkin = Checkin.new(manual_checkin_resources_params)
    elsif params[:button] == 'automatic'
      @checkin = Checkin.new(automatic_checkin_resources_params)
      ip = request.remote_ip

      if ip != "127.0.0.1"
        @checkin.location_ip = ip
        result = Geocoder.search(@checkin.location_ip)
        @checkin.location_name = result.first.city
      end
    end

    @checkin.user = user

    if (@checkin.save)
      redirect_to home_index_path
    else
      render 'new'
    end
  end

  def update
    if(@checkin.update(manual_checkin_resources_params))
      redirect_to account_home_path
    else
      render 'edit'
    end
  end

  def destroy
    @checkin.destroy!
  end

  private

  def manual_checkin_resources_params
    params.require(:checkin).permit(:location_name, :image, :latitude, :longitude)
  end

  def automatic_checkin_resources_params
    params.require(:checkin).permit(:image, :latitude, :longitude, :location_ip)
  end

  def load_checkin
    @checkin = Checkin.find(params[:id])
  end

  def authorise_to_edit_checkin
    redirect_to(account_home_path) unless current_user == @checkin.user
  end

end
