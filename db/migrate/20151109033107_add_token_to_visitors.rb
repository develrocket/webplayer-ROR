class AddTokenToVisitors < ActiveRecord::Migration
  def change
    add_column :visitors, :token, :string
  end
end
