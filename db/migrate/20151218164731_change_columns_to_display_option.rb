class ChangeColumnsToDisplayOption < ActiveRecord::Migration
  def change
    remove_column :display_options, :birds_eye
    remove_column :display_options, :show_aerial
    add_column :display_options, :birds_eye_view, :boolean, default: true
    add_column :display_options, :show_aerial_view, :boolean, default: true
  end
end
