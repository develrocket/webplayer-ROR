class Add2ColumnsToVisitor < ActiveRecord::Migration
  def change
    add_column :visitors, :is_verified, :boolean, default: false
    add_column :visitors, :access_requested, :boolean, default: false
  end
end
