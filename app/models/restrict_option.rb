class RestrictOption < ActiveRecord::Base
  validates :review_seconds, :numericality => { :greater_than_or_equal_to => 0 }
end
