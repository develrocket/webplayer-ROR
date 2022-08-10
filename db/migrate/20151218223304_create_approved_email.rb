class CreateApprovedEmail < ActiveRecord::Migration
  def change
    create_table :approved_emails do |t|
      t.string :email, default: ''
      t.integer :tour_id, default: 0
      t.timestamps
    end
  end
end
