class CreateDisplayOptions < ActiveRecord::Migration
  def change
    create_table :display_options do |t|
      t.boolean :show_google45_imagery
      t.boolean :show_exterior_walkin
      t.boolean :show_detach_unit
      t.text :tooltip
    end
  end
end
