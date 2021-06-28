class Checkin < ApplicationRecord
  validates :location_name, presence: true, unless: :location_ip
  validates :location_ip, presence: true, unless: :location_name

  belongs_to :user

  geocoded_by :location_name
  after_validation :geocode

  mount_uploader :image, ImageUploader

  paginates_per 10

  scope :most_recent_first, -> {order(created_at: :desc)}
  scope :current_location, -> (user) { where(user_id: user.id).order("created_at").last }

end
