class AddReviewSecondsToRestrictOption < ActiveRecord::Migration
  def change
    add_column :restrict_options, :review_seconds, :integer, default: 60
  end
end
