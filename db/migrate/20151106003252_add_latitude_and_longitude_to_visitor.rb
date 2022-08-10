class AddLatitudeAndLongitudeToVisitor < ActiveRecord::Migration
  def change
    add_column :visitors, :latitude, :float
    add_column :visitors, :longitude, :float
    add_column :visitors, :city, :string
    add_column :visitors, :state, :string
  end
end
