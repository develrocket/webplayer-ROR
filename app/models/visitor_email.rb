class VisitorEmail < ActiveRecord::Base
  has_many :visitor
  has_many :visitor_log, through: :visitor
end
