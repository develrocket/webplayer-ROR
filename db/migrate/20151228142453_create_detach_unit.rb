class CreateDetachUnit < ActiveRecord::Migration
  def change
    create_table :detach_units do |t|
      t.string :address, default: ''
      t.integer :tour_id, default: 0
      t.timestamps

    end
  end
end
