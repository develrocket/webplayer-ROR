class AddlinkToDetachUnit < ActiveRecord::Migration
  def change
    add_column :detach_units, :link, :string, default: ''
  end
end
