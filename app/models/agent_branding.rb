class AgentBranding < ActiveRecord::Base
  belongs_to :company

  has_attached_file :avatar,
                    styles: { medium: "600x600>", thumb: "600x600>" },
                    :storage => :s3,
                    :s3_credentials => Proc.new{|a| a.instance.s3_credentials },
                    :url => ":s3_domain_url",
                    :path => "agent_branding/:id/:filename",
                    default_url: "missing.png"
  validates_attachment :avatar,
                       content_type: { content_type: /\Aimage\/.*\Z/ }

  def s3_credentials
    {:bucket => ENV['S3_BUCKET_NAME'], :access_key_id => ENV['AWS_ACCESS_KEY_ID'], :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']}
  end
end
