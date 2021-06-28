class CreateCheckins < ActiveRecord::Migration[5.1]
  def change
    create_table :checkins do |t|
      t.float :latitude
      t.float :longitude
      t.string :locationName
      t.string :image

      t.timestamps
    end
  end
end
