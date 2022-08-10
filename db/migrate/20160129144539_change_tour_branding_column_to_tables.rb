class ChangeTourBrandingColumnToTables < ActiveRecord::Migration
  def change
    change_column :admin_account_activities, :tour_branding, :boolean, default: true
    change_column :tours, :is_tour_branding, :boolean, default: true
  end
end
