class CreateVisitorLog < ActiveRecord::Migration
  def change
    create_table :visitor_logs do |t|
      t.integer :visitor_id, default: 0
      t.integer :duration_time, default: 0
      t.timestamps
    end
  end
end
