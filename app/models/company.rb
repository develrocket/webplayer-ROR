class Company < ActiveRecord::Base

  has_attached_file :logo,
                    styles: { medium: "500x500>", thumb: "500x500>" },
                    :storage => :s3,
                    :s3_credentials => Proc.new{|a| a.instance.s3_credentials },
                    :url => ":s3_domain_url",
                    :path => "company/:id/:filename",
                    default_url: "missing.png"
  validates_attachment :logo,
                       content_type: { content_type: /\Aimage\/.*\Z/ }

  validates :name, :allow_blank => true, uniqueness: { message: " has already been taken" }
  has_many :agent_info

  def logo_url
    logo.url(:medium)
  end

  def s3_credentials
    {:bucket => ENV['S3_BUCKET_NAME'], :access_key_id => ENV['AWS_ACCESS_KEY_ID'], :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']}
  end
end
