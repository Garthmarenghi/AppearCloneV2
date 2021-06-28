class Invitation < ApplicationRecord
  belongs_to :user

  # method to check if there is any record of interaction between two users, ie if there is a pending request
  def self.reacted?(id1, id2)
    case1 = !Invitation.where(user_id: id1, friend_id: id2).empty?
    case2 = !Invitation.where(user_id: id2, friend_id: id1).empty?
    case1 || case2
  end

  def self.sent_but_no_response?(sender, recipient)
    !Invitation.where(user_id: sender, friend_id: recipient, confirmed: false).empty?
  end

  # method to check if two people have agreed to be friends
  def self.confirmed_record?(id1, id2)
    case1 = !Invitation.where(user_id: id1, friend_id: id2, confirmed: true).empty?
    case2 = !Invitation.where(user_id: id2, friend_id: id1, confirmed: true).empty?
    case1 || case2
  end

  # find the invitation record of two given ids that are friends, can use this to delete a friendship
  def self.find_confirmed_invitation(id1, id2)
    if Invitation.where(user_id: id1, friend_id: id2, confirmed: true).empty?
      Invitation.where(user_id: id2, friend_id: id1, confirmed: true)[0].id
    else
      Invitation.where(user_id: id1, friend_id: id2, confirmed: true)[0].id
    end
  end

  # find the id of the pending invitation between two users
  def self.find_pending(sender, recipient)
    Invitation.where(user_id: sender, friend_id: recipient, confirmed: false).pluck(:id).first
  end

end
