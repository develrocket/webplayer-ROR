class Backend::AdminController < ApplicationController
  layout 'application_admin'
  before_action :authenticate_admin!, :check_company_permission, :set_gon_value
  skip_before_filter :check_company_permission, :only => [:remove_image, :store_notification]

  def index
    if current_admin.super?
      @admins = Admin.where(super:false)
    else
      # if current_admin.agent_type.to_i != 1  and current_admin.agent_info.company_id.to_i != 0
      #   @admins = Admin.includes(:agent_info).where(super:false).where(agent_infos: {company_id: current_admin.agent_info.company_id})
      # end

      redirect_to client_edit_path(current_admin.id)
    end
  end

  def new
    @admin = Admin.new
    @store_path = client_create_path

    # new agent info for image tag, only in new page is needed
    @agent_info = AgentInfo.new

    @company = Company.new
  end

  def create

    # check agent type, depends on company or individual agent
    check_account_type

    if current_admin.agent_type.to_i == 3
      params[:admin][:agent_type] = 1
      params[:agent_info][:company_id] = current_admin.agent_info.company_id
    end

    @admin = Admin.new(admin_params)

    # skip first or last name with belows param values only needs when create
    @admin.skip_first_name = @skip_first_name
    @admin.skip_last_name = @skip_last_name

    # check company params
    check_company_params

    if params[:agent_info][:license_number].blank?
      params[:agent_info].delete(:license_number)
    end

    # define store path
    @store_path = client_add_path

    # set default login password to email notification message content
    html_content = <<-HTML
      <p>Email: #{params[:admin][:email]}</p>
      <p>Password: #{params[:admin][:password]}</p>
    HTML

    @admin.build_agent_info(agent_info_params)
    @admin.build_notification
    @admin.build_admin_account_activity(admin_account_activity_params)
    @admin.agent_info.build_company(company_params) if params[:admin][:agent_type].to_i != 1

    @admin.notification.additional_email_content = html_content.to_s

    respond_to do |format|
      if @admin.save and @admin.agent_info.save and @admin.agent_info.company.save and @admin.notification.save

        # store_company
        @admin.agent_info.company.update(logo: params[:logo]) if params[:logo] and !params[:company][:name].blank?

        format.html { redirect_to client_index_path, notice: 'Agent was successfully created.' }
        format.json { render json: client_index_path, status: :created, location: @admin }
      else
        @admin.destroy
        format.html { render action: "new", notice: @admin.agent_info.errors }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end

  def delete
    @admin = Admin.find(params[:id])

    respond_to do |format|
      if @admin.destroy
        format.html { redirect_to client_index_path, notice: 'Client was successfully removed.' }
        format.json { render json: client_index_path, status: :created, location: @admin }
      else
        format.html { render action: "index", notice: @admin.errors }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit

    @admin = Admin.find(params[:id])

    if @admin.agent_info.company_id != 0
      @company = Company.find(@admin.agent_info.company_id)
    else @company = Company.new end

    @store_path = client_update_path
  end

  def edit_ajax
    edit
    respond_to do |format|
      format.html{ render :layout => false }
    end
  end

  # account tab edit for client
  def edit_account_ajax
    @admin = Admin.find(params[:id])

    respond_to do |format|
      format.html{ render :layout => false }
    end
  end

  # account tab update via ajax for client
  def update_account_ajax
    @admin = Admin.find(params[:id])

    # password is not required fields when update
    # if params[:admin][:password].blank? && params[:admin][:password_confirmation].blank?
    #   params[:admin].delete(:password)
    #   params[:admin].delete(:password_confirmation)
    # end

    respond_to do |format|
      if @admin.update_attributes(client_account_params)
        sign_in(@admin, :bypass => true) if @admin == current_admin
        # format.html { redirect_to client_index_path, notice: 'Agent was successfully updated.' }
        format.json { render json: {name:'Account was successfully updated.'}, status: :ok}

      else
        # format.html { render action: "edit", notice: @admin.errors }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end

  end

  # agents_list in client side
  def agents_list
    @admins = Admin.where("admins.id != ?", current_admin.id).includes(:agent_info)
                  .where({super:false})
                  .where(agent_infos: {company_id: current_admin.agent_info.company_id})
    respond_to do |format|
      format.html{ render 'backend/admin/_index', :layout => false }
    end
  end

  def view
    @admin = Admin.find(params[:id])
  end
  def view_ajax
    view
    respond_to do |format|
      format.html{ render 'backend/admin/_view', :layout => false }
    end
  end

  def update
    # check agent type, depends on company or individual agent
    check_account_type

    # password is not required fields when update
    if params[:admin][:password].blank? && params[:admin][:password_confirmation].blank?
      params[:admin].delete(:password)
      params[:admin].delete(:password_confirmation)
    end

    @admin = Admin.find(params[:id])
    @store_path = client_update_path

    # company validation check when company id is nil should create new
    check_company_params
    company_save = params[:admin][:agent_type].to_i == 1 ? true : @admin.company.update_attributes(company_params)

    respond_to do |format|
      if @admin.update_attributes(admin_params) && \
          @admin.agent_info.update_attributes(agent_info_params) && \
          @admin.admin_account_activity.update_attributes(admin_account_activity_params) && \
          @admin.notification.update_attributes(admin_notification_params) && \
          company_save

        if company_save
          @admin.company.update(logo: params[:company][:logo]) if params[:company][:logo]
        end
        # store_company

        # format.html { redirect_to client_index_path, notice: 'Agent was successfully updated.' }
        format.json { render json: {name:'Agent was successfully updated.'}, status: :ok}

      else
        # format.html { render action: "edit", notice: @admin.errors }

        format.json { render json: @admin.errors, :include => :agent_info, status: :unprocessable_entity }
      end
    end
  end

  # update account in client side
  def update_for_client
    # check agent type, depends on company or individual agent
    check_account_type

    @admin = Admin.find(params[:id])
    @store_path = update_for_client_path

    # password is not required fields when update
    if params[:admin][:password].blank? && params[:admin][:password_confirmation].blank?
      params[:admin].delete(:password)
      params[:admin].delete(:password_confirmation)
    end

    # company validation check when company id is nil should create new
    check_company_params

    company_save = params[:admin][:agent_type].to_i == 1 ? true : @admin.company.update_attributes(company_params)

    respond_to do |format|
      if @admin.update_attributes(admin_params) && \
          @admin.agent_info.update_attributes(agent_info_params) && company_save

        if company_save
          @admin.company.update(logo: params[:company][:logo]) if params[:company][:logo]
        end

        # store_company

        # format.html { redirect_to client_index_path, notice: 'Agent was successfully updated.' }
        format.json { render json: {name:'Agent was successfully updated.'}, status: :ok}

      else
        # format.html { render action: "edit", notice: @admin.errors }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # get company by id in edit / new page by ajax
  def get_company_by_id
    @company = Company.find(params[:company_id])

    respond_to do |format|
      if @company != nil
        format.js {}
        format.json { render :json =>@company.to_json(:only => [:id, :name], :methods => [:logo_url]) }
      else
        format.html { render action: 'index' }
        format.json { render json: 'failed', status: :unprocessable_entity }
      end
    end
  end

  # get tours by admin id
  def client_get_tours
    @admin = Admin.find(params[:id])
    @tours = @admin.tour
  end

  def notification
    @admin = Admin.find(params[:id])
    @store_path = store_notification_path

    respond_to do |format|
      format.html { render 'backend/admin/_notification', :layout => false }
    end
  end

  def store_notification
    @admin = Admin.find(params[:id])
    respond_to do |format|
      if @admin.notification and @admin.notification.update_attributes(notification_params)

        # format.html { redirect_to tour_notification_index_path, notice: 'Tour Notification was successfully updated.' }
        format.json { render json: { name: 'Tour Notification was successfully updated.' }, status: :ok }
      else
        # format.html { redirect_to tour_notification_index_path, notice: @tour.errors }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # send account created notification to client
  def account_create_notification
    admin_id = params[:admin_id]
    admin = Admin.find(admin_id.to_i)
    perform_result = SubscribeMailer.send_account_noti_client(admin).deliver

    respond_to do |format|
      if perform_result.perform_deliveries
        format.json { render json: { result: true }, status: :ok }
      else
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # remove image
  def remove_image
    admin_id = params[:admin_id]
    type = params[:type]
    admin = Admin.find(admin_id)

    if type.to_s == 'avatar'
      admin.agent_info.avatar.clear
    else admin.agent_info.company.logo.clear end

    default_image_src = ActionController::Base.helpers.asset_path('missing.png')

    respond_to do |format|
      if admin.agent_info.save && admin.agent_info.company.save
        format.json { render json: { result: true, default_image_src: default_image_src }, status: :ok }
      else
        format.json { render json: { result: false }, status: :unprocessable_entity }
      end
    end
  end

  private

  def check_authorization
    authenticate_admin!

    unless current_admin.super?
      redirect_to webplayer_basic_index_path
    end
  end

  def admin_params
    params.require(:admin).permit(:username, :email, :password, :password_confirmation, :first_name,
                                  :last_name, :agent_type)
  end

  def client_account_params
    params.require(:admin).permit(:password, :password_confirmation)
  end

  def agent_info_params
    params.require(:agent_info).permit(:title, :website, :license_number, :office_phone,
                                  :mobile_phone, :fax, :fb_profile, :twitter_profile, :office_address,
                                  :city, :zip_code, :company_id, :state_id, :company_id)
  end

  def admin_account_activity_params
    params.require(:admin_account_activity).permit(:tour_branding, :agent_branding, :display_contents, :restriction_option,
                                       :data_log, :statistic)
  end
  def company_params
    params.require(:company).permit(:name)
  end

  # account type check first, last name is not needed in case of company(2 types)
  def check_account_type
    if params[:admin][:agent_type] != 1
      if params[:admin][:first_name].blank?
        params[:admin].delete(:first_name)
        @skip_first_name = true
      end
      if params[:admin][:last_name].blank?
        params[:admin].delete(:last_name)
        @skip_last_name = true
      end
    end
  end

  # company validation check when company id is nil should create new
  def check_company_params
    if params[:admin][:agent_type].to_i == 1
      params[:company].delete(:name) if params[:company] and params[:company][:name].present?
      params[:company].delete(:logo)  if params[:logo].present?
    else
      params[:agent_info][:company_id] = @admin.agent_info.company_id if @admin.agent_info
    end

    if params[:agent_info][:company_id].blank? || params[:agent_info][:company_id] == 0
      params[:agent_info][:company_id] = 0

    #   if params[:company] and params[:company][:name].present?
    #     @company = Company.new(company_params)
    #   else @company = Company.new end
    # else
    #   @company = Company.find(params[:agent_info][:company_id])
    end
  end

  # company update
  def store_company
    @company.is_brokerage = true if params[:admin][:agent_type].to_i == 2
    if @company.save
      @company.update(logo: params[:logo]) if params[:logo]
      @admin.agent_info.update(company_id: @company.id)
    end

    if params[:company] and params[:company][:name].present?
      @company.update(company_params)
    end

    if params[:agent_info][:avatar]
      @admin.agent_info.update(avatar: params[:agent_info][:avatar]) end
  end

  def notification_params
    params.require(:notification).permit(:message)
  end

  def admin_notification_params
    params.require(:notification).permit(:additional_email_content)
  end

  def set_gon_value
    gon.store_visit_time_path = store_visit_time_path
    gon.remove_image_path = remove_image_for_admin_path
  end
end
