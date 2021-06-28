class AddUserToCheckin < ActiveRecord::Migration[5.1]
  def change
    add_reference :checkins, :user, foreign_key: true
  end
end
