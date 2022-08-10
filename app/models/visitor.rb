class Visitor < ActiveRecord::Base
  belongs_to :tour
  belongs_to :visitor_email
  has_many :visitor_log
end
