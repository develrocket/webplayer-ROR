class AddTourBrandingToTables < ActiveRecord::Migration
  def change
    add_column :admin_account_activities, :tour_branding, :boolean, default: false
    add_column :tours, :is_tour_branding, :boolean, default: false
  end
end
