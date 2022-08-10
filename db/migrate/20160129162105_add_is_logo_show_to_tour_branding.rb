class AddIsLogoShowToTourBranding < ActiveRecord::Migration
  def change
    add_column :tour_brandings, :is_logo_show, :boolean, default: true
  end
end
