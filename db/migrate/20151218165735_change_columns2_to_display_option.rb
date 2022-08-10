class ChangeColumns2ToDisplayOption < ActiveRecord::Migration
  def change
    remove_column :display_options, :aerial_view
    remove_column :display_options, :birds_eye_view
    add_column :display_options, :show_aerial, :boolean, default: true
    add_column :display_options, :show_birds_eye, :boolean, default: true
  end
end
