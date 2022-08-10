class AddIsBrokerageToCompany < ActiveRecord::Migration
  def change
    add_column :companies, :is_brokerage, :string, default: ''
  end
end
