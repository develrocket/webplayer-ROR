class CreateRestrictOption < ActiveRecord::Migration
  def change
    create_table :restrict_options do |t|
      t.boolean :email
      t.boolean :email_confirmation
      t.boolean :name
      t.boolean :message
      t.boolean :phone
      t.boolean :agent_approval
      t.boolean :send_inquire
      t.boolean :walkintour
      t.boolean :google45_imagery
      t.boolean :exterior_walkin
      t.boolean :detach_unit
      t.text :tooltip
    end
  end
end
