class AddLocationIpToCheckin < ActiveRecord::Migration[5.1]
  def change
    add_column :checkins, :locationIp, :string
  end
end
