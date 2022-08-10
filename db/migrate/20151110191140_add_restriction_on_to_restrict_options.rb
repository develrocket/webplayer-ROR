class AddRestrictionOnToRestrictOptions < ActiveRecord::Migration
  def change
    add_column :restrict_options, :restrict_on, :boolean, null: false, default: false
  end
end
