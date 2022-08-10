class Backend::TourController < ApplicationController
  layout 'application_admin'
  before_action :authenticate_admin!, :check_company_permission, :set_constant_value, :set_gon_value
  skip_before_filter :check_company_permission, :only => [:index, :remove_image]
  def index
    if current_admin.super?
      @tours = Tour.all
    else
      get_tours
    end
  end

  def new
    @remote = false
    @tour = Tour.new
    @store_path = tour_create_path
  end

  def create
    @remote = false
    @store_path = tour_create_path
    @tour = Tour.new

    unit_addresses = params[:detach_unit_address]
    unit_links = params[:detach_unit_link]

    @tour.build_webplayer_basic(webplayer_basic_params)
    @tour.build_agent_branding
    @tour.build_display_option
    @tour.build_restrict_option
    @tour.build_tour_branding

    respond_to do |format|
      if @tour.save and @tour.webplayer_basic.save

        @tour.detach_unit.destroy_all
        unless unit_addresses.blank?
          unit_addresses.each_with_index { |address, index|
            @tour.detach_unit.create({address: address, link: unit_links[index]}) unless unit_addresses.blank?
          }
        end

        @tour.webplayer_basic.update(brand: params[:webplayer_basic][:brand]) if params[:webplayer_basic][:brand] and params[:webplayer_basic][:is_brand_show].to_f == 1
        @tour.webplayer_basic.update(media: params[:webplayer_basic][:media]) if params[:webplayer_basic][:media] and params[:webplayer_basic][:is_media_show].to_f == 1

        format.html { redirect_to tour_edit_webplayer_basic_path(@tour.id), notice: 'Tour was successfully created.' }
        format.json { render json: tour_index_path, status: :created, location: @tour }
      else
        @tour.destroy
        format.html { render action: "new", notice: @tour.errors }
        format.json { render json: @tour.errors, status: :unprocessable_entity }
      end
    end
  end

  def delete
    @tour = Tour.find(params[:id])
    respond_to do |format|
      if @tour.destroy
        format.html { redirect_to tour_index_path, notice: 'Tour was successfully removed.' }
        format.json { render json: tour_index_path, status: :created, location: @tour }
      else
        format.html { render action: "index", notice: @tour.errors }
        format.json { render json: @tour.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit_webplayer_basic
    @tour = Tour.find(params[:id])

    check_company_permission

    @url = 'http://walkinplayer.herokuapp.com/' + @tour.id.to_s
    @store_path = tour_update_webplayer_basic_path

  end

  def edit_webplayer_basic_ajax
    edit_webplayer_basic

    respond_to do |format|
      format.html { render :layout => false }
    end
  end

  def update_webplayer_basic
    @store_path = tour_update_webplayer_basic_path
    @tour = Tour.find(params[:id])
    unit_addresses = params[:detach_unit_address]
    unit_links = params[:detach_unit_link]

    respond_to do |format|
      if @tour.webplayer_basic.update_attributes(webplayer_basic_params)
        @tour.detach_unit.destroy_all

        unless unit_addresses.blank?
          unit_addresses.each_with_index { |address, index|
            @tour.detach_unit.create({address: address, link: unit_links[index]}) unless unit_addresses.blank?
          }
        end
        @tour.webplayer_basic.update(brand: params[:webplayer_basic][:brand]) if params[:webplayer_basic][:brand] and params[:webplayer_basic][:is_brand_show].to_f == 1
        @tour.webplayer_basic.update(media: params[:webplayer_basic][:media]) if params[:webplayer_basic][:media] and params[:webplayer_basic][:is_media_show].to_f == 1

        # format.html { redirect_to tour_update_webplayer_basic_path, notice: 'Tour Webplayer Basic was successfully updated.' }
        # format.json { render json: tour_index_path, status: :updated, location: @tour }
        format.json { render json: {name: 'Tour Webplayer Basic was successfully updated.'}, status: :ok }
      else
        format.json { render json: @tour.errors, status: :unprocessable_entity }
        # format.json { render json: @tour.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit_ownership
    @tour = Tour.find(params[:id])
    @store_path = tour_update_ownership_path

    respond_to do |format|
      format.html { render :layout => false }
    end
  end

  def update_ownership
    @tour = Tour.find(params[:id])
    @store_path = tour_update_ownership_path

    respond_to do |format|
      if @tour.update_attributes(tour_params)

        # format.html { redirect_to tour_edit_ownership_path, notice: 'Tour Ownership was successfully updated.' }
        # format.json { render json: tour_index_path, status: :updated, location: @tour }
        format.json { render json: {name: 'Tour Ownership was successfully updated.'}, status: :ok }
      else
        # format.html { render action: "edit_ownership", notice: @tour.errors }
        # format.json { render json: @tour.errors, status: :unprocessable_entity }
        format.json { render json: @tour.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit_tour_branding
    @tour = Tour.find(params[:id])
    @store_path = tour_update_tour_branding_path

    respond_to do |format|
      format.html { render :layout => false }
    end
  end

  def update_tour_branding
    @tour = Tour.find(params[:id])
    @store_path = tour_update_tour_branding_path

    respond_to do |format|
      if @tour.tour_branding.update_attributes(tour_branding_params)
        @tour.tour_branding.update(logo: params[:tour_branding][:logo]) if params[:tour_branding][:logo]

        # format.html { redirect_to tour_edit_agent_branding_path, notice: 'Tour Agent Branding was successfully updated.' }
        # format.json { render json: tour_index_path, status: :updated, location: @tour }
        format.json { render json: {name: 'Tour Tour Branding was successfully updated.'}, status: :ok }
      else
        # format.html { redirect_to tour_edit_agent_branding_path, notice: @tour.errors }
        # format.json { render json: @tour.errors, status: :unprocessable_entity }
        format.json { render json: @tour.errors, status: :unprocessable_entity }
      end
    end

  end

  def edit_agent_branding
    @tour = Tour.find(params[:id])
    @store_path = tour_update_agent_branding_path

    respond_to do |format|
      format.html { render :layout => false }
    end
  end

  def update_agent_branding
    @tour = Tour.find(params[:id])
    @store_path = tour_update_agent_branding_path

    params[:agent_info][:company_id] = 0 if params[:agent_info][:company_id].blank?

    respond_to do |format|
      if @tour.admin.update_attributes(admin_params) && @tour.admin.agent_info.update_attributes(agent_info_params)

        @tour.agent_branding.update(avatar: params[:agent_branding][:avatar]) if params[:agent_branding] && params[:agent_branding][:avatar]
        # format.html { redirect_to tour_edit_agent_branding_path, notice: 'Tour Agent Branding was successfully updated.' }
        # format.json { render json: tour_index_path, status: :updated, location: @tour }
        format.json { render json: {name: 'Tour Agent Branding was successfully updated.'}, status: :ok }
      else
        # format.html { redirect_to tour_edit_agent_branding_path, notice: @tour.errors }
        # format.json { render json: @tour.errors, status: :unprocessable_entity }
        format.json { render json: @tour.errors, status: :unprocessable_entity }
      end
    end

  end

  def edit_display_contents
    @tour = Tour.find(params[:id])
    @store_path = tour_update_display_contents_path

    respond_to do |format|
      format.html { render :layout => false }
    end
  end

  def update_display_contents
    @tour = Tour.find(params[:id])
    @store_path = tour_update_display_contents_path

    respond_to do |format|
      if @tour.display_option and @tour.display_option.update_attributes(display_option_params)

        # format.html { redirect_to tour_edit_display_contents_path, notice: 'Tour Agent Branding was successfully updated.' }
        # format.json { render json: tour_index_path, status: :updated, location: @tour }
        format.json { render json: {name: 'Tour Display Content successfully updated.'}, status: :ok }
      else
        # format.html { redirect_to tour_edit_display_contents_path, notice: @tour.errors }
        # format.json { render json: @tour.errors, status: :unprocessable_entity }
        format.json { render json: @tour.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit_restrict_options
    @tour = Tour.find(params[:id])
    @store_path = tour_update_restrict_options_path

    respond_to do |format|
      format.html { render :layout => false }
    end
  end

  def update_restrict_options
    @tour = Tour.find(params[:id])
    @store_path = tour_update_restrict_options_path

    restrict_option = @tour.restrict_option
    check_restriction_level restrict_option

    respond_to do |format|
      if @tour.restrict_option and @tour.restrict_option.update_attributes(restrict_option_params)

        # format.html { redirect_to tour_edit_restrict_options_path, notice: 'Tour Restrict Options was successfully updated.' }
        # format.json { render json: tour_index_path, status: :updated, location: @tour }
        format.json { render json: {name: 'Tour Restrict Option successfully updated.'}, status: :ok }
      else
        # format.html { redirect_to tour_edit_restrict_options_path, notice: @tour.errors }
        # format.json { render json: @tour.errors, status: :unprocessable_entity }
        format.json { render json: @tour.errors, status: :unprocessable_entity }
      end
    end
  end

  def data_log
    @tour = Tour.find(params[:id])

    check_company_permission

    data_log_index
  end

  def visitor_detail
    @tour = Tour.find(params[:id])
    @visitor_log = VisitorLog.find(params[:visitor_log_id])
    respond_to do |format|
      format.html { render :layout => false }
      format.js
    end
  end

  def approved_email_list
    @tour = Tour.find(params[:id])
    @store_path = tour_store_approved_email_path
    preapproved_email_list
    respond_to do |format|
      format.html { render :layout => false }
      format.js
    end
  end

  def store_approved_email
    @store_path = tour_store_approved_email_path
    store_preapproved_email

    respond_to do |format|
      if @approved_email.save
        html_tag = <<-HTML
          <a class="btn btn-info btn-xs" id="edit_row" data-id="#{@approved_email.id}" data-email="#{@approved_email.email}" href="#">
            <i class="fa fa-edit">Edit</i>
          </a>
          <a class="btn btn-danger btn-xs m-l-sm" id="delete_row" confirm="Are you sure?" href="#{tour_delete_approved_email_path(:id => @approved_email.tour_id, :approved_email_id => @approved_email.id)}">
            <i class="fa fa-trash-o">Delete</i>
          </a>
        HTML
        # format.html { redirect_to tour_approved_email_list_path, notice: 'Email was successfully saved.' }
        format.json { render json: {approved_email: @approved_email, html_tag: html_tag, mode: @mode}, status: :created }
      else
        # format.html { render action: "approved_email_list", notice: @approved_email.errors }
        format.json { render json: @approved_email.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  def delete_approved_email
    @approved_email = ApprovedEmail.find(params[:approved_email_id])
    respond_to do |format|
      if @approved_email.destroy
        # format.html { redirect_to tour_approved_email_list_path, notice: 'Email was successfully removed.' }
        format.json { render :json => {:result => 'success'} }
      else
        # format.html { render action: "index", notice: @approved_email.errors }
        format.json { render json: 'failed', status: :unprocessable_entity }
      end
    end
  end

  def statistic
    @tour = Tour.find(params[:id])
    statistic_index

    respond_to do |format|
      format.html { render :layout => false }
    end
  end

  # remove image ajax
  def remove_image
    tour_id = params[:tour_id]
    type = params[:type]

    tour = Tour.find(tour_id.to_i)

    if type.to_s == 'tour_branding'
      tour.tour_branding.logo.clear
    elsif type.to_s == 'agent_branding'
      tour.agent_branding.avatar.clear
    elsif type.to_s == 'webplayer_brand'
      tour.webplayer_basic.brand.clear
    elsif type.to_s == 'webplayer_media'
      tour.webplayer_basic.media.clear
    end

    default_image_src = ActionController::Base.helpers.asset_path('grey-box.png')

    respond_to do |format|
      if tour.tour_branding.save && tour.agent_branding.save && tour.webplayer_basic.save
        format.json { render json: { result: true, default_image_src: default_image_src }, status: :ok }
      else
        format.json { render json: { result: false }, status: :unprocessable_entity }
      end
    end
  end

  # get admin by admin id
  def get_admin_by_id
    admin_id = params[:admin_id]
    admin = Admin.find(admin_id)
    respond_to do |format|
      format.json { render json: { admin: admin.admin_account_activity }, status: :ok }
    end
  end

  private

  def set_constant_value
    @remote = true
  end

  def webplayer_basic_params
    params.require(:webplayer_basic).permit(:tour_address, :matterport_link, :height, :width,
                                            :is_brand_show, :exterior_link, :default_unit_name,
                                            :is_media_show, :brand_width, :brand_height, :media_width, :media_height, :ad_link)
  end

  def tour_params
    params.require(:tour).permit(:admin_id, :is_tour_branding, :is_agent_branding, :is_display_contents, :is_restriction_option,
                                 :is_data_log, :is_statistic)
  end

  def admin_params
    params.require(:admin).permit(
        :first_name,
        :last_name
    )
  end

  def agent_info_params
    params.require(:agent_info).permit(
        :mobile_phone,
        :company_id,
        :title
    )
  end

  def display_option_params
    params.require(:display_option).permit(
        :show_aerial,
        :show_birds_eye,
        :show_exterior_walkin,
        :show_detach_unit,
    )
  end

  def restrict_option_params
    params.require(:restrict_option).permit(:email, :email_confirmation, :name, :message, :phone, :agent_approval,
                                            :send_inquire, :walkintour, :google45_imagery, :exterior_walkin,
                                            :detach_unit, :restrict_on, :review_seconds)
  end

  def approve_visitor_access
    visitor = Visitor.find(params[:visitor_id])

    respond_to do |format|
      if visitor.update(is_verified: true)
        perform_result = SubscribeMailer.send_noti_to_visitor(visitor).deliver

        if perform_result.perform_deliveries
          result = true
        else
          result = false
        end

        format.js {}
        format.json { render :json => {:result => result} }
      else
        format.html { render action: 'index' }
        format.json { render json: 'failed', status: :unprocessable_entity }
      end
    end
  end

  def approved_email_params
    params.require(:approved_email).permit(:email)
  end
  def tour_branding_params
    params.require(:tour_branding).permit(:logo_width, :logo_height, :is_logo_show)
  end

  def set_gon_value
    gon.remove_image_path = remove_image_for_tour_path
    gon.tour_get_admin_by_id = tour_get_admin_by_id_path
  end
end
