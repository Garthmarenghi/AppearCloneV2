class AddCurrentLongitudeToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :current_longitude, :float
  end
end
