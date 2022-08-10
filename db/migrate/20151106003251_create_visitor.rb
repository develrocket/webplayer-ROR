class CreateVisitor < ActiveRecord::Migration
  def change
    create_table :visitors do |t|
      t.string :email
      t.string :ip_address
      t.boolean :is_verified
      t.timestamp :last_visit_time
      t.string :location
      t.string :country
      t.string :browser
      t.string :name
      t.text :notes
      t.text :tooltip
    end
  end
end
