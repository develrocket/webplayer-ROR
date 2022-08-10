class CreateAdminAccountActivity < ActiveRecord::Migration
  def change
    create_table :admin_account_activities do |t|
      t.integer :admin_id, null:false, default: 0
      t.boolean :agent_branding, default: true
      t.boolean :display_contents, default: true
      t.boolean :restriction_option, default: true
      t.boolean :data_log, default:true
      t.boolean :statistic, default:true
    end
  end
end
