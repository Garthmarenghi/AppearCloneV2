class User < ApplicationRecord
  has_secure_password

  has_many :checkins
  has_many :invitations

  # Look for invitations that are not confirmed.
  has_many :pending_invitations, -> { where confirmed: false }, class_name: 'Invitation', foreign_key: "friend_id"

  before_validation :downcase_email
  before_validation :downcase_user_name
  validates :email, uniqueness: true, presence: true
  validates :name, presence: true

  mount_uploader :avatar, AvatarUploader

  paginates_per 6

  scope :search, -> (search_term) {if (search_term)
                                    where('name LIKE ?', "%#{search_term.downcase}%")
                                  else
                                    where('name LIKE ?', "%#{search_term}%")
                                  end}

  # Method to return all friends of a user
  def friends
    friends_i_invited = Invitation.where(user_id: id, confirmed: true).pluck(:friend_id)
    friends_that_invited_me = Invitation.where(friend_id: id, confirmed: true).pluck(:user_id)
    all_friends = friends_i_invited + friends_that_invited_me
    User.where(id: all_friends)
  end

  # Method to return boolean whether friendship exists or not.
  def friend_with?(user)
    Invitation.confirmed_record?(id, user.id)
  end

  # Method to return boolean when any pending friend request
  def pending_request?(user)
    Invitation.reacted?(id, user.id)
  end

  # method to return boolean when waiting for a reply
  def waiting_for_reply?(user)
    Invitation.sent_but_no_response?(id, user.id)
  end

  def pending_my_action
    friends_that_invited_me = Invitation.where(friend_id: id, confirmed: false).pluck(:user_id)
    User.where(id: friends_that_invited_me)
  end

  def find_the_pending_invitation_to(user)
    Invitation.find_pending(id, user.id)
  end

  def find_confirmed_relationship_to(user)
    Invitation.find_confirmed_invitation(id, user.id)
  end

  def distance_to(friend)
    current_user_coordinates = [Checkin.current_location(self).latitude,Checkin.current_location(self).longitude]
    friend_coordinates = [Checkin.current_location(friend).latitude,Checkin.current_location(friend).longitude]
    Geocoder::Calculations.distance_between(current_user_coordinates, friend_coordinates, options = {units: :km}).round
  end

  private

  def downcase_email
    self.email = email.downcase
  end

  def downcase_user_name
    self.name = name.downcase
  end
end
