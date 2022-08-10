class CreateAgentBranding < ActiveRecord::Migration
  def change
    create_table :agent_brandings do |t|
      t.string :tour_id
      t.string :avatar
      t.string :branded_url
      t.string :embed_code
      t.string :first_name
      t.string :last_name
      t.string :phone
      t.string :company_id
      t.timestamps
    end
  end
end
