class ChangeColumns1ToDisplayOption < ActiveRecord::Migration
  def change
    remove_column :display_options, :show_aerial_view
    add_column :display_options, :aerial_view, :boolean, default: true
  end
end
