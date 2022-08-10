class HomeController < ApplicationController
  before_action :set_gon_value
  def index_branded
    @branded = true
    index
    render 'home/index'
  end

  def index_tour_branded
    @branded = true
    @tour_branded = true

    # @tour = Tour.find(params[:id])
    # redirect_to home_index_path unless @tour.is_tour_branding

    index

    render 'home/index'
  end

  def index
    # ahoy track
    ahoy.track "Viewed book", title: "Track visitors"

    require "rubygems"
    require "browser"

    # get visitor ip address
    @client_ip = remote_ip

    # check visitor id /:id or not
    if params[:id]
      @tour = Tour.find(params[:id])
    else @tour = Tour.first end

    # get visitor by ip address
    visitor = Visitor.where(tour_id:@tour.id).find_by_ip_address(@client_ip)

    # record visitor process
    visitor = record_visitor(visitor)

    # store visitor email to var
    if visitor.visitor_email
      gon.visitor_email = visitor.visitor_email.email
    else
      gon.visitor_email = ''
    end

    # # record visitor_log
    # if flash[:notice] and flash[:notice] == 'email_confirmed'
    # else gon.visitor_log = VisitorLog.create({visitor_id: visitor.id, visit_time: Time.now})
    # end

    # store tours and restrict options to var
    # gon.tour = @tour
    gon.restrict_on = @tour.restrict_option.restrict_on
    gon.restrict_name = @tour.restrict_option.name
    gon.restrict_message = @tour.restrict_option.message
    gon.restrict_phone = @tour.restrict_option.phone

    gon.review_seconds = @tour.restrict_option.review_seconds
    gon.review_seconds = 1 if @tour.restrict_option.review_seconds.to_i == 0

    #get visit time
    gon.time_diff = @time_diff = ((Time.now - visitor.last_visit_time) / 1.minute).round

    gon.visitor = @visitor = visitor

    # store bootbox load path to var
    gon.get_bootbox1_content_path = get_bootbox1_content_path(visitor.id)
    gon.get_bootbox2_content_path = get_bootbox2_content_path(visitor.id)
    gon.get_bootbox3_content_path = get_bootbox3_content_path(visitor.id)
    gon.get_bootbox4_content_path = get_bootbox4_content_path(visitor.id)
    gon.visitor_log = visitor.visitor_log.first()

    # get agent branding image
    @is_brand_image = false
    if !@tour.agent_branding.avatar.blank?
      @is_brand_image = true
      @brand_image_url = @tour.agent_branding.avatar.url
    elsif @tour.admin.agent_type.to_i == 1
      @is_brand_image = true unless @tour.admin.agent_info.avatar.blank?
      @brand_image_url = @tour.admin.agent_info.avatar.url
    else
      @is_brand_image = true unless @tour.admin.agent_info.company.logo.blank?
      @brand_image_url = @tour.admin.agent_info.company.logo.url
    end

    @is_tour_brand_image = false

    # tour brand image url
    if @tour.tour_branding.is_logo_show and !@tour.tour_branding.logo.blank? and @branded and @tour.is_tour_branding
      @tour_brand_image_url = @tour.tour_branding.logo.url
      @is_tour_brand_image = true
    else
      @tour_brand_image_url = @tour.webplayer_basic.brand.url
      @is_tour_brand_image = true if @tour.webplayer_basic.is_brand_show
    end
  end

  #  get visitor ip address
  def remote_ip
    begin
      if request.remote_ip == '127.0.0.1'
        # Hard coded remote address
        '36.37.174.196'
      else
        request.remote_ip
      end
    rescue Timeout::Error, Errno::EINVAL, Errno::ECONNRESET, EOFError,
        Net::HTTPBadResponse, Net::HTTPHeaderSyntaxError, Net::ProtocolError => e
      ''
    end

  end

  # subscribe
  def subscribe_visitor
    visitor = Visitor.find(params[:visitor_id])
    @tour = Tour.find(visitor.tour_id)

    verified = false
    access_requested = false
    result = false

    # restrict option email confirmation is checked or not
    if @tour.restrict_option.email_confirmation
      if params[:email].present?

        visitor_email = VisitorEmail.where("email = ?", params[:email].downcase).first

        # check per-approved email
        approved_email = ApprovedEmail.where(tour_id:@tour.id).find_by_email(params[:email].downcase)
        if approved_email
          unless visitor_email
            visitor_email = VisitorEmail.create({email:params[:email].downcase, is_verified: TRUE})
          end
            visitor.update(is_verified: TRUE, visitor_email_id: visitor_email.id)
          verified = TRUE
        # verifed visitor_email exist or not
        else
          if visitor_email and visitor_email.is_verified

            #  visitor update visitor's email
            visitor.update(visitor_email_id: visitor_email.id)

            # visitor check if visitor email is already verified on this tour
            visitor2 = Visitor.where(tour_id:@tour.id).where(is_verified:TRUE).find_by_visitor_email_id(visitor_email.id)
            if visitor2
              visitor.update(is_verified: TRUE)
              verified = TRUE
            end

            # ----------------------- email verified check process -------------------------------
            if @tour.restrict_option.agent_approval
              visitor.update(access_requested: TRUE)
              visitor.visitor_log.order(created_at: 'DESC').first.update(access_requested: true)

              if @tour.restrict_option.send_inquire
                approve_token = self.generate_token(32)
                visitor.update(approve_access_token: approve_token)
                perform_result = SubscribeMailer.send_inquire_approval_agent(visitor, @tour.admin).deliver

                if perform_result.perform_deliveries
                  SubscribeMailer.send_noti_to_visitor(visitor).deliver
                end
              end
            elsif @tour.restrict_option.email_confirmation
              visitor.update(is_verified: TRUE)
              verified = TRUE
            end

            # if visitor is not verified yet, send email
            # if !visitor.is_verified and !visitor.access_requested
            #   result = send_email(params[:email], visitor)
            # else result = true end
            access_requested = visitor.access_requested

            result = verified
          else
            result = send_email(params[:email].downcase, visitor) end
        end
      else result = false end

    else
      if params[:email].present?
        visitor_email = VisitorEmail.where(email: params[:email].downcase).first_or_create
        visitor.visitor_email_id = visitor_email.id
      end
      visitor.is_verified = true
      result = true
      verified = true
    end

    visitor_log = visitor.visitor_log.order(created_at: 'DESC').first

    if params[:name].present?
      visitor.name = params[:name]
      visitor_log.name = params[:name]
    end

    if params[:phone].present?
      visitor.phone = params[:phone]
      visitor_log.phone = params[:phone]
    end

    if params[:message].present?
      visitor.message = params[:message]
      visitor_log.message = params[:message]
      if @tour.admin.notification.message
        SubscribeMailer.message_notification2agent(visitor, params[:message]).deliver
      end
    end

    visitor.save
    visitor_log.save

    if request.xhr?
      render :json => {
                 :result => result,
                 :verified => verified,
                 :access_requested => access_requested
             }
    end
  end

  # index file load first bootbox form based on restrict option by visitor id
  def load_bootbox1
    @visitor = Visitor.find(params[:id])
    @tour = Tour.find(@visitor.tour_id)
    respond_to do |format|
      format.html { render :layout => false }
      format.js
    end
  end

  # index file load second bootbox form based on restrict option
  def load_bootbox2
    @visitor = Visitor.find(params[:id])
    @tour = Tour.find(@visitor.tour_id)
    @resend_email_path = resend_subscribe_email_path
    respond_to do |format|
      format.html { render :layout => false }
      format.js
    end
  end

  # index file load third bootbox form based on restrict option
  def load_bootbox3
    @visitor = Visitor.find(params[:id])
    @tour = Tour.find(@visitor.tour_id)
    respond_to do |format|
      format.html { render :layout => false }
      format.js
    end
  end

  # index file load additional bootbox for phone, message and name restriction field
  def load_bootbox4
    @visitor = Visitor.find(params[:id])

    @name_required = params[:name_required]
    @phone_required = params[:phone_required]
    @message_required = params[:message_required]

    @tour = Tour.find(@visitor.tour_id)
    respond_to do |format|
      format.html { render :layout => false }
      format.js
    end

  end

  # add additional information to visitor
  def add_information_visitor
    visitor = Visitor.find(params[:visitor_id])
    visitor_log = visitor.visitor_log.order(created_at: 'DESC').first

    visitor_log.name = visitor.name = params[:name] if params[:name].present?
    visitor_log.phone = visitor.phone = params[:phone] if params[:phone].present?
    visitor_log.message = visitor.message = params[:message] if params[:message].present?

    visitor.save
    visitor_log.save

    if request.xhr?
      render :json => {
                 :result => visitor,
             }
    end
  end

  # resend subscriber email(based on email has been sent and email confirmation is required)
  def resend_subscribe_email
    visitor = Visitor.find(params[:visitor_id])
    result = false
    result = send_email(visitor.visitor_email.email, visitor) if visitor.visitor_email
    if request.xhr?
      render :json => {
                 :result => result,
             }
    end
  end

  # confirm email from email inbox link by token
  def confirm_email_by_token
    @token = params[:token]
    visitor = Visitor.find_by_token(@token)
    @client_ip = remote_ip

    @tour = Tour.find(params[:id])
    # record visitor process
    visitor1 = Visitor.find_by_ip_address(@client_ip)
    visitor1 = record_visitor(visitor1)

    access_requested = false
    if visitor
      tour = Tour.find(visitor.tour_id)
      @email_verified = true
      if tour.restrict_option.agent_approval
        visitor.update(access_requested:TRUE)
        access_requested = true
      else
        visitor.update(is_verified: TRUE)
      end
      visitor.visitor_email.update(is_verified: TRUE)

      if tour.restrict_option.send_inquire
        approve_token = self.generate_token(32)
        visitor.update(approve_access_token: approve_token)
        perform_result = SubscribeMailer.send_inquire_approval_agent(visitor, tour.admin).deliver
        if perform_result.perform_deliveries
          SubscribeMailer.send_noti_to_visitor(visitor).deliver
        end
      end

      # record visitor log
      VisitorLog.create(:visitor_id => visitor.id, :access_requested => access_requested, :visit_time => Time.now)

      visitor1.update(is_verified:visitor.is_verified, access_requested:visitor.access_requested, visitor_email_id:visitor.visitor_email_id)
      redirect_to home_index_path(visitor.tour_id.to_i), :notice => 'email_confirmed'
    else @email_verified = false end

  end

  # store visitor duration time
  def store_visit_time
    type = params[:store_type]

    if type.to_s == 'new'
      visitor = Visitor.find(params[:visitor_id])
      # record visitor_log
      if flash[:notice] and flash[:notice] == 'email_confirmed'
      else visitor_log = VisitorLog.create({visitor_id: visitor.id, visit_time: Time.now}) end
    else
      visitor_log = VisitorLog.find(params[:visitor_log_id])

      visitor = Visitor.find(visitor_log.visitor_id)
      current_time = Time.now

      if visitor_log
        duration = (Time.parse(current_time.to_s) - Time.parse(visitor.last_visit_time.to_s))
        visitor_log.update(duration_time: duration)
        visitor.update({duration_time: duration, last_visit_time: Time.now})
      end

      visitor_log = VisitorLog.create(:visitor_id => visitor.id, :visit_time => Time.now) if type.to_s == 'visible'
    end

    if request.xhr?
      render :json => {
                 :result => visitor_log,
             }
    end
  end

  # redirect to home index page
  def redirect_to_index
    redirect_to home_index_path
  end

  # approve visitor access by token from email link
  def approve_access_by_token
    token = params[:token]
    visitor = Visitor.where(approve_access_token:token).first()
    visitor.is_verified = true
    @visitor = visitor
    visitor.save
  end
  protected

  #create token value
  def generate_token(length)
    SecureRandom.hex[0,length].upcase
  end

  private

  # send email to user to verify user email(account)
  def send_email(email, visitor)
    tour = Tour.find(visitor.tour_id)

    token = self.generate_token(32)

    perform_result = SubscribeMailer.send_email(email, visitor, tour.restrict_option.email_confirmation, token).deliver

    if perform_result.perform_deliveries
      visitor_email = VisitorEmail.where(email: email).first_or_create
      visitor.update(token: token, visitor_email_id:visitor_email.id)
      result = true
    else result = false end

    result
  end

  def record_visitor(visitor)
    # get additional information by ip
    begin
      geo_result1 = GeoIp.geolocation(@client_ip)
    rescue
      geo_result2 = request.location
    end

    # check visitor is new or not
    if visitor
      # set user visit time after get time diff since last visited
      visitor.last_visit_time = Time.now
      gon.new_user = false
    else
      gon.new_user = true
      visitor = Visitor.new

      visitor.ip_address = @client_ip
      tour = Tour.find(params[:id])
      visitor.last_visit_time = Time.now
      visitor.browser = browser.name
      visitor.tour_id = @tour.id
    end

    #get browser name via browser gem
    visitor.browser = browser.name

    # check GeoIP result or not
    if geo_result1.present? and !geo_result1.blank?
      visitor.country = geo_result1[:country_name]
      visitor.city = geo_result1[:city]
      visitor.state = geo_result1[:region_name]
      visitor.latitude = geo_result1[:latitude]
      visitor.longitude = geo_result1[:longitude]
    end

    # check geocoder result
    if geo_result2.present? and !geo_result2.blank?
      visitor.country = geo_result2.country
      visitor.city = geo_result2.city
      visitor.state = geo_result2.state
      visitor.latitude = geo_result2.latitude
      visitor.longitude = geo_result2.longitude
    end

    visitor.save

    visitor
  end

  # get current time based on client(brokerage)'s time zone
  def get_current_time admin_id
    admin = Admin.find(admin_id)
    begin
      timezone = Timezone::Zone.new :latlon => [admin.latitude.to_f, admin.longitude.to_f]
      timezone.time(Time.now)
    rescue
      Time.now
    end
  end

  def set_gon_value
    gon.store_visit_time_path = store_visit_time_path
  end
end
