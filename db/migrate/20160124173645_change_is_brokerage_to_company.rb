class ChangeIsBrokerageToCompany < ActiveRecord::Migration
  def change
    remove_column :companies, :is_brokerage
    add_column :companies, :is_brokerage,  :boolean, default: FALSE
  end
end
