class AddApproveTokenToVisitor < ActiveRecord::Migration
  def change
    add_column :visitors, :approve_access_token, :string, default: ''
  end
end
