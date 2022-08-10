class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
      record.errors[attribute] << (options[:message] || "is not an email")
    end
  end
end

class ApprovedEmail < ActiveRecord::Base

  validates :email, presence: true, email: true, :uniqueness => { :scope => :tour_id, message: " has already been taken" }

  belongs_to :tour
end
