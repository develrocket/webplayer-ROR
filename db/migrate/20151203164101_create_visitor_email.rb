class CreateVisitorEmail < ActiveRecord::Migration
  def change
    create_table :visitor_emails do |t|
      t.string :email, null:false, default: ''
      t.boolean :is_verified, null:false, default: FALSE
      t.boolean :access_requested, null:false, default: FALSE
    end
  end
end
