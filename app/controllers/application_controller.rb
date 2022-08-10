class ApplicationController < ActionController::Base
  before_filter :configure_permitted_parameters, if: :devise_controller?
  # rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  def after_sign_in_path_for(resource)
    backend_index_path
  end

  def after_sign_out_path_for(resource_or_scope)
    new_admin_session_path
  end

  def page_not_found
    respond_to do |format|
      format.html { render template: 'errors/not_found_error', layout: 'layouts/application', status: 404 }
      format.all  { render nothing: true, status: 404 }
    end
  end
  protected

  def configure_permitted_parameters
    registration_params = [:username, :email, :password, :password_confirmation]

    if params[:action] == 'update'
      devise_parameter_sanitizer.for(:account_update) {
          |u| u.permit(registration_params << :current_password)
      }
    elsif params[:action] == 'create'
      devise_parameter_sanitizer.for(:register) {
          |u| u.permit(registration_params)
      }
    end
  end

  # get tour for client(in client side)
  def get_tours
    if current_admin.agent_type.to_i == 3
      # records = Admin.includes(:agent_info).where(agent_infos: {company_id: current_admin.agent_info.company_id})
      # sorted_records = ids.collect {|id| records.detect {|x| x.id == id}}

      records = Admin.includes(:agent_info).where(agent_infos: {company_id: current_admin.agent_info.company_id}).pluck(:id)
      @tours = Tour.where(:admin_id => records)
    else
      @tours = Tour.where(:admin_id => current_admin.id)
    end
    gon.remove_image_path = remove_image_for_tour_path
  end

  # check client permission (in client side)
  def check_permission_for_client!
    # if super admin, redirect to client index page
    redirect_to client_index_path if current_admin.super?

    if params[:id]
      # check tour permission, that is cant access other client's tour
      @tour = Tour.find(params[:id])
      redirect_to backend_index_path if @tour.admin_id != current_admin.id

      # check tour activity
      if (params[:controller] == 'backend/client/agent_branding' and !@tour.is_agent_branding) ||
          (params[:controller] == 'backend/client/display_content' and !@tour.is_display_contents) ||
          (params[:controller] == 'backend/client/restrict_option' and !@tour.is_restriction_option) ||
          (params[:controller] == 'backend/client/visitor' and !@tour.is_data_log) ||
          (params[:controller] == 'backend/client/statistic' and !@tour.is_statistic)
        redirect_to backend_index_path
      end
    end

  end

  # data log index page
  def data_log_index
    # @logs = initialize_grid(@tour.visitor_log)
    # visitor_logs = VisitorLog.joins("LEFT JOIN visitors ON visitor_logs.visitor_id = visitors.id")
    #           .joins("LEFT JOIN visitor_emails ON visitors.visitor_email_id = visitor_emails.id")
    @tour.visitor_log.where("created_at <= ?", Time.zone.now.beginning_of_day).where({duration_time: 0, access_requested: false, name: '', phone: '', message: ''}).delete_all
    @visitor_data_log_grid = initialize_grid(@tour.visitor_log,
                                             order: 'created_at',
                                             order_direction: 'desc',
                                             include: [:visitor],
                                             per_page: 10,
                                             name: 'g1',
                                             enable_export_to_csv: true,
                                             csv_field_separator: ',',
                                             csv_file_name: 'visitor_logs'
    )

    export_grid_if_requested('g1' => 'visitor_data_log_grid') do
      # usual render or redirect code executed if the request is not a CSV export request
    end
  end

  # pre approved email
  def preapproved_email_list
    @approved_emails = ApprovedEmail.where(:tour_id => params[:id])
    @approved_email = ApprovedEmail.new
    @mode = 'Create'
  end

  # store pre approved email
  def store_preapproved_email
    @approved_emails = ApprovedEmail.where(:tour_id => params[:id])
    if params[:approved_email_id].blank?
      @approved_email = ApprovedEmail.new(approved_email_params)
      @approved_email.tour_id = params[:id]
      @mode = 'Create'
    else
      @approved_email = ApprovedEmail.find(params[:approved_email_id])
      @approved_email.email = params[:approved_email][:email]
      @mode = 'Update'
    end
  end

  # check restriction level(in restrict option section)
  def check_restriction_level restrict_option
    #check restriction option email confirmation is filled
    if !restrict_option.email_confirmation
      if params[:restrict_option][:email_confirmation].to_i == 1
        @tour.visitor.each{ |visitor|
          visitor.update(is_verified: false)
        }
      end
    elsif !restrict_option.agent_approval
      if params[:restrict_option][:agent_approval].to_i == 1
        @tour.visitor.each{ |visitor|
          if visitor.is_verified
            visitor_log = visitor.visitor_log.order(created_at: 'DESC')
            visitor.visitor_log.order(created_at: 'DESC').first.update(access_requested: true)
            visitor.update(access_requested:true)
          end
          visitor.update(is_verified: false)
        }
      end
    elsif restrict_option.agent_approval
      if params[:restrict_option][:agent_approval].to_i == 0
        @tour.visitor.each{ |visitor|
          if visitor.access_requested
            visitor_log = visitor.visitor_log.order(created_at: 'DESC')
            visitor.update(is_verified: TRUE)
          end
        }
      end
    end

    # if !restrict_option.message
    #   if params[:restrict_option][:message].to_i == 1
    #     @tour.visitor.each{ |visitor|
    #       visitor.update(is_verified: false)
    #     }
    #   end
    # end
  end

  # statistic index
  def statistic_index
    ActiveRecord::Base.default_timezone = :utc
    @log_day_dates = []
    @log_day_data = []

    @log_week_dates = []
    @log_week_data = []

    @log_month_dates = []
    @log_month_data = []

    visitor_logs1 = @tour.visitor_log
    @visitor_logs = visitor_logs = visitor_logs1.where.not(duration_time: 0)
    month_amount = 0
    week_amount = 0

    # group by month views report
    visitors_by_month = visitor_logs.group_by_day(:created_at, range: 1.month.ago.midnight..Time.now, format: "%d %b").count
    visitors_by_month.each_with_index {|visitor_log, index|
      @log_month_dates[index] = visitor_log[0]
      @log_month_data[index] = visitor_log[1]
      month_amount += visitor_log[1]
    }
    @visitors_month_average = @log_month_data.inject(0.0) { |sum, el| sum + el } / @log_month_dates.size
    @month_average_time_group = visitor_logs.group_by_day(:created_at, range: 1.month.ago.midnight..Time.now).average(:duration_time).to_a.sort_by(&:first)
    average_time = month_amount / @month_average_time_group.size
    @month_average_time = formatted_duration average_time

    # group by week views report
    visitors_by_week = visitor_logs.group_by_day(:created_at, range: 1.weeks.ago.midnight..Time.now, format: "%a").count
    visitors_by_week.each_with_index {|visitor_log, index|
      @log_week_dates[index] = visitor_log[0]
      @log_week_data[index] = visitor_log[1]
      week_amount += visitor_log[1]
    }
    @visitors_week_average = @log_week_data.inject(0.0) { |sum, el| sum + el } / @log_week_dates.size
    @week_average_time_group = visitor_logs.group_by_day(:created_at, range: 1.weeks.ago.midnight..Time.now).average(:duration_time).to_a.sort_by(&:first)
    average_time = week_amount / @week_average_time_group.size
    @week_average_time = formatted_duration average_time

    # group by day views report
    visitors_by_day = visitor_logs.where("created_at >= ?", Time.zone.now.beginning_of_day).group_by_hour(:created_at, format: "%-l %P").count
    visitors_by_day.each_with_index {|visitor_log, index|
      @log_day_dates[index] = visitor_log[0]
      @log_day_data[index] = visitor_log[1]
    }
    today_amount = visitor_logs.where("created_at >= ?", Time.zone.now.beginning_of_day).sum(:duration_time)
    @visitors_date_average = @log_day_dates.size.to_i == 0 ? 0 : (@log_day_data.inject(0.0) { |sum, el| sum + el } / @log_day_dates.size)
    @date_average_time_group = visitor_logs.where("created_at >= ?", Time.zone.now.beginning_of_day).group_by_hour(:created_at, format: "%-l %P").average(:duration_time).to_a.sort_by(&:first)
    average_time =  @date_average_time_group.size.to_i == 0 ? 0 : (today_amount / @date_average_time_group.size)
    @date_average_time = formatted_duration average_time

    # Demographics
    # @country_group = visitor_logs.group("country").count
    @country_group = visitor_logs.select('visitors.country, count(visitor_logs.*) as count,
                                          avg(visitor_logs.duration_time) as duration_time,
                                          MIN(visitor_logs.duration_time) AS min_duration_time,
                                          MAX(visitor_logs.duration_time) AS max_duration_time')
                                 .group('country')
    @city_group = visitor_logs.select('visitors.city, count(visitor_logs.*) as count,
                                          avg(visitor_logs.duration_time) as duration_time,
                                          MIN(visitor_logs.duration_time) AS min_duration_time,
                                          MAX(visitor_logs.duration_time) AS max_duration_time')
                              .group('city')
    @view_custom_by_date = view_custom_by_date_path
  end

  # check permission for agent in client side
  def check_company_permission
    result = false
    if params[:id].present? and params[:id].to_i != 0
      if params[:controller].to_s == 'backend/admin'
        admin = Admin.find(params[:id])
      else admin = Tour.find(params[:id]).admin end

      unless admin.blank?
        if current_admin.agent_type == 3
          result = true if current_admin.agent_info.company_id == admin.agent_info.company_id
        else
          result = true if current_admin.id == admin.id
        end
      end

      result = true if current_admin.super?

    else
      result = true
      unless current_admin.super?
         result = false if current_admin.agent_type != 3
      end
    end
    redirect_to client_edit_path(current_admin.id) unless result
  end

  private

  def record_not_found
    page_not_found
  end

  def formatted_duration t
    Time.at(t).utc.strftime("%H:%M:%S")
=begin
    mm, ss = t.divmod(60)            #=> [4515, 21]
    hh, mm = mm.divmod(60)           #=> [75, 15]
    dd, hh = hh.divmod(24)
    "#{ hh.to_i }:#{ mm }:#{ ss }"
=end
  end

end
