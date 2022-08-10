class AddPhoneAndMessageToVisitors < ActiveRecord::Migration
  def change
    add_column :visitors, :phone, :string
    add_column :visitors, :message, :text
  end
end
