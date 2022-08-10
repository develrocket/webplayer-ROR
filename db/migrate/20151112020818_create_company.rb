class CreateCompany < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name, null: false, default:""
      t.string :logo

      t.timestamps
    end
  end
end
