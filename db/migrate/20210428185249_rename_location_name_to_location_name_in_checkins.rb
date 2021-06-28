class RenameLocationNameToLocationNameInCheckins < ActiveRecord::Migration[5.1]
  def up
    rename_column :checkins, :locationName, :location_name
  end

  def down
    rename_column :checkins, :location_name, :locationName
  end
end
