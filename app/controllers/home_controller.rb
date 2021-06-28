class HomeController < ApplicationController
  include HomeHelper
  
  before_action :ensure_authenticated,                 only: :index
  before_action :ensure_user_has_at_least_one_checkin, only: :index

  def index
    @my_location = Checkin.current_location(current_user)

    @friends = current_user.friends.sort_by{|user| user.distance_to(current_user)}

    if @friends.any?
      @distance_to_furthest_friend = current_user.distance_to(@friends.last)
      @friends.each do |friend|
        friend.current_latitude = Checkin.current_location(friend).latitude
        friend.current_longitude = Checkin.current_location(friend).longitude
      end
    end
  end

  def about
  end
end
