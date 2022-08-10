class AddEmailIdToVisitor < ActiveRecord::Migration
  def change
    add_column :visitors, :email_id, :string, default:0
  end
end
