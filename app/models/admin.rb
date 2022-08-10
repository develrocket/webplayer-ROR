class Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  default_scope { order(id: 'ASC') }

  attr_accessor :skip_first_name, :skip_last_name

  # validates :username, format: { with: /\A[a-zA-Z0-9_-]+\z/, message: "Special charactors not allowed" }
  validates :username, presence: true
  # validates :first_name, format: { with: /\A[a-zA-Z0-9]+\z/, message: "Special charactors not allowed" }, unless: :skip_first_name
  # validates :last_name, format: { with: /\A[a-zA-Z0-9]+\z/, message: "Special charactors not allowed" }, unless: :skip_last_name

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :agent_info, autosave: true, :dependent => :destroy
  has_one :admin_account_activity, :dependent => :destroy
  has_one :notification, :autosave => true, :dependent => :destroy
  has_many :tour
  belongs_to :country
  belongs_to :state
  has_one :company, :through => :agent_info, autosave: true

  def is_agent_info?
    !self.agent_info.nil?
  end


  private

  # custom validation methods
  def method_first_name
  end
  def method_last_name
  end
end
