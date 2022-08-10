class ChangeReviewSecondsToRestrictOption < ActiveRecord::Migration
  def change
    change_column :restrict_options, :review_seconds, :integer, default: 20
  end
end
