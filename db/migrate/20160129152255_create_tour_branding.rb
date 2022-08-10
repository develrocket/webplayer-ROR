class CreateTourBranding < ActiveRecord::Migration
  def change
    create_table :tour_brandings do |t|
      t.integer :tour_id, default: 0
      t.string :logo, default: ''

      t.timestamps null: false
    end
  end
end
