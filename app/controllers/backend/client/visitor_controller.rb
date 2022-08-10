class Backend::Client::VisitorController < ApplicationController
  before_action :authenticate_admin!, :check_permission_for_client!, :get_tours
  skip_before_filter :check_permission_for_client!, :get_tours, :only => [:approve_visitor_access, :get_approved_email_table_row]
  layout 'application_admin'

  def index
    get_tour_by_id!
    # @logs = initialize_grid(@tour.visitor_log)
    data_log_index
  end

  def detail
    @visitor_log = VisitorLog.find(params[:visitor_log_id])
    respond_to do |format|
      format.html { render :layout => false }
      format.js
    end
  end

  def approve_visitor_access
    visitor = Visitor.find(params[:visitor_id])

    respond_to do |format|
      if visitor.update(is_verified: true)
        perform_result = SubscribeMailer.send_noti_to_visitor(visitor).deliver

        if perform_result.perform_deliveries
          result = true
        else result = false end

        format.js {}
        format.json { render :json => { :result => result} }
      else
        format.html { render action: 'index' }
        format.json { render json: 'failed', status: :unprocessable_entity }
      end
    end
  end
  def approved_email_list
    @tab_name = 'Visitor Data logs'
    @store_path = store_approved_email_path

    preapproved_email_list

    respond_to do |format|
      format.html { render :layout => false }
      format.js
    end
  end
  def store_approved_email
    @store_path = store_approved_email_path
    store_preapproved_email

    respond_to do |format|
      if @approved_email.save
        html_tag = <<-HTML
          <a class="btn btn-info btn-xs" id="edit_row" data-id="#{@approved_email.id}" data-email="#{@approved_email.email}" href="#">
            <i class="fa fa-edit">Edit</i>
          </a>
          <a class="btn btn-danger btn-xs m-l-sm" id="delete_row" confirm="Are you sure?" href="#{delete_approved_email_path(:id => @approved_email.tour_id, :approved_email_id => @approved_email.id)}">
            <i class="fa fa-trash-o">Delete</i>
          </a>
        HTML
        # format.html { redirect_to tour_approved_email_list_path, notice: 'Email was successfully saved.' }
        format.json { render json: {approved_email: @approved_email, html_tag: html_tag, mode: @mode}, status: :created}
      else
        # format.html { render action: "approved_email_list", notice: @approved_email.errors }
        format.json { render json: @approved_email.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  # delete approved email
  def delete_approved_email
    @approved_email = ApprovedEmail.find(params[:approved_email_id])
    respond_to do |format|
      if @approved_email.destroy
        # format.html { redirect_to approved_email_list_path, notice: 'Email was successfully removed.' }
        format.json { render :json => { :result => 'success'} }
      else
        # format.html { render action: "index", notice: @approved_email.errors }
        format.json { render json: @approved_email.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def get_tour_by_id!
    if params[:id]
      @tour = Tour.find(params[:id])
    else
      @tour = @tours[0]
      if @tour.blank?
        respond_to do |format|
          format.html { render 'backend/client/blank' }
          format.json
        end
      else
      end
    end
    @tab_name = 'Visitor Data logs'
  end

  def approved_email_params
    params.require(:approved_email).permit(:email)
  end
end
