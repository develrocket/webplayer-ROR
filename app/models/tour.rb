class Tour < ActiveRecord::Base

  belongs_to :admin
  has_one :webplayer_basic, :autosave => true, :dependent => :destroy
  has_one :agent_branding, :autosave => true, :dependent => :destroy
  has_one :display_option, :autosave => true, :dependent => :destroy
  has_one :restrict_option, :autosave => true, :dependent => :destroy
  has_one :tour_branding, :autosave => true, :dependent => :destroy
  has_many :visitor
  has_many :visitor_log, through: :visitor
  has_many :approved_email
  has_many :detach_unit, :dependent => :destroy
end
