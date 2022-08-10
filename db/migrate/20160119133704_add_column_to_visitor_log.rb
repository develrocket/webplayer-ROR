class AddColumnToVisitorLog < ActiveRecord::Migration
  def change
    add_column :visitor_logs, :name, :string, default: ''
    add_column :visitor_logs, :phone, :string, default: ''
    add_column :visitor_logs, :message, :string, default: ''
  end
end
