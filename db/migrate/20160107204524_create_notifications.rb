class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :tour_id, default: 0
      t.boolean :message, default: false

      t.timestamps null: false
    end
  end
end
