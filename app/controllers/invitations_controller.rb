class InvitationsController < ApplicationController
  before_action :ensure_authenticated
  before_action :ensure_user_has_at_least_one_checkin
  before_action :load_invitation,                     only: [:update, :destroy]
  before_action :ensure_FR_exists,                    only: [:update, :destroy]
  before_action :ensure_no_invitation_already_exists, only: [:create]


  def create
    @invite = Invitation.new(new_friend_invitation_params)
    @invite.user_id = current_user.id
    @invite.save!
  end

  def update
    @invite.confirmed = true
    @invite.save!
  end

  def destroy
    @invite.destroy!

    redirect_to root_path
  end

  private

  def load_invitation
    @invite = Invitation.find(params[:id])
  end

  def new_friend_invitation_params
    params.permit(:friend_id)
  end

  def ensure_no_invitation_already_exists
    redirect_to(root_path) if current_user.pending_request?(User.find(new_friend_invitation_params[:friend_id])) || current_user.friend_with?(User.find(new_friend_invitation_params[:friend_id]))
  end

  def ensure_FR_exists
    redirect_to(root_path) unless @invite
  end
end
