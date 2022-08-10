class AddTwoColumnsToTourBranding < ActiveRecord::Migration
  def change
    add_column :tour_brandings, :logo_width, :string, default: ''
    add_column :tour_brandings, :logo_height, :string, default: ''
  end
end
