class AddCurrentLatitudeToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :current_latitude, :float
  end
end
