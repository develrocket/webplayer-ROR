class AgentInfo < ActiveRecord::Base
  has_attached_file :avatar,
                    styles: { medium: "300x300>", thumb: "100x100>" },
                    :storage => :s3,
                    :s3_credentials => Proc.new{|a| a.instance.s3_credentials },
                    :url => ":s3_domain_url",
                    :path => "agent_info/:id/:filename",
                    default_url: "missing.png"
  validates_attachment :avatar,
                       content_type: { content_type: /\Aimage\/.*\Z/ }
  validates :license_number, :allow_blank => true, uniqueness: { message: " has already been taken" }
  # validates_uniqueness_of :acronym, :allow_blank => true, :scope => [:group_id], :case_sensitive => false
  belongs_to :company, autosave: true

  def small_avatar_url
    avatar.url(:thumb)
  end

  def s3_credentials
    {:bucket => ENV['S3_BUCKET_NAME'], :access_key_id => ENV['AWS_ACCESS_KEY_ID'], :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']}
  end
end
