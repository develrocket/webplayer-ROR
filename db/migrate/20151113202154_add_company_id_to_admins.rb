class AddCompanyIdToAdmins < ActiveRecord::Migration
  def change
    add_column :admins, :company_id,  :integer, null: false, default: 0
  end
end
