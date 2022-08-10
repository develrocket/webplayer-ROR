class WebplayerBasic < ActiveRecord::Base
  self.table_name = "webplayer_basics"

  has_attached_file :brand,
                    styles: { medium: "500x500>", thumb: "500x500>" },
                    :storage => :s3,
                    :s3_credentials => Proc.new{|a| a.instance.s3_credentials },
                    :url => ":s3_domain_url",
                    :path => "webplayer_basic_brand/:id/:filename",
                    default_url: "walkintour-logo.png"
  validates_attachment :brand,
                       content_type: { content_type: /\Aimage\/.*\Z/ }

  has_attached_file :media,
                    styles: { medium: "300x300>", thumb: "300x300>" },
                    :storage => :s3,
                    :s3_credentials => Proc.new{|a| a.instance.s3_credentials },
                    :url => ":s3_domain_url",
                    :path => "webplayer_basic_media/:id/:filename",
                    default_url: "grey-box.png"
  validates_attachment :media,
                       content_type: { content_type: /\Aimage\/.*\Z/ }

  validates :tour_address, presence: true
  validates :matterport_link, presence: true
  validates :height, presence: true
  validates :width, presence: true

  def s3_credentials
    {:bucket => ENV['S3_BUCKET_NAME'], :access_key_id => ENV['AWS_ACCESS_KEY_ID'], :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']}
  end
end
