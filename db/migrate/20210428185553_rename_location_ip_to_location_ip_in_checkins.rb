class RenameLocationIpToLocationIpInCheckins < ActiveRecord::Migration[5.1]
  def up
    rename_column :checkins, :locationIp, :location_ip
  end

  def down
    rename_column :checkins, :location_ip, :locationIp
  end
end
