class AddOneColumnAndChangeColumnToDisplayOption < ActiveRecord::Migration
  def change
    add_column :display_options, :birds_eye, :boolean, default: true
    remove_column :display_options, :show_google45_imagery, :boolean, default: true
    add_column :display_options, :show_aerial, :boolean, default: true
  end
end
