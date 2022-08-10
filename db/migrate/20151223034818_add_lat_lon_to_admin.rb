class AddLatLonToAdmin < ActiveRecord::Migration
  def change
    add_column :admins, :latitude, :float, default: 0.0
    add_column :admins, :longitude, :float, default: 0.0
  end
end
