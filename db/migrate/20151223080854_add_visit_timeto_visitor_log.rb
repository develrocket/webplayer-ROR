class AddVisitTimetoVisitorLog < ActiveRecord::Migration
  def change
    add_column :visitor_logs, :visit_time, :timestamp
  end
end
