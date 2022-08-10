class AddPasscodeToVisitors < ActiveRecord::Migration
  def change
    add_column :visitors, :passcode, :string
  end
end
