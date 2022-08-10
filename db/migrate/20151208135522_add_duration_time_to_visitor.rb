class AddDurationTimeToVisitor < ActiveRecord::Migration
  def change
    add_column :visitors, :duration_time, :integer, default: 0
    remove_column :visitors, :passcode
    remove_column :visitors, :location
  end
end
