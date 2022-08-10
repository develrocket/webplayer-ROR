class Backend::Client::StatisticController < ApplicationController
  before_action :authenticate_admin!, :check_permission_for_client!, :get_tours
  skip_before_filter :check_permission_for_client!, :get_tours, :only => :view_custom_by_date
  layout 'application_admin'
  def index
    get_tour_by_id!

    statistic_index

    respond_to do |format|
      format.html{ render :layout => false }
    end
  end

  def view_custom_by_date
    ActiveRecord::Base.default_timezone = :utc

    tour_id = params[:tour_id]
    start_date = params[:start_date]
    end_date = params[:end_date]

    log_day_dates = []
    log_day_data = []
    visitors_date_average = '00:00:00'
    date_average_time = 0

    @tour = Tour.find(tour_id.to_i)
    visitor_logs = @tour.visitor_log.where.not(duration_time: 0).where(:created_at => DateTime.parse(start_date).beginning_of_day..DateTime.parse(end_date).end_of_day)
    total_amount = 0
    # group by date views report
    unless visitor_logs.blank?
      visitors_by_day = visitor_logs.group_by_day(:created_at, format: "%d %b").count
      visitors_by_day.each_with_index {|visitor_log, index|
        log_day_dates[index] = visitor_log[0]
        log_day_data[index] = visitor_log[1]
        total_amount += visitor_log[1]
      }
      visitors_date_average = log_day_data.inject(0.0) { |sum, el| sum + el } / log_day_dates.size
      date_average_time_group = visitor_logs.group("DATE(created_at)").average(:duration_time).to_a.sort_by(&:first)
      average_time = total_amount / date_average_time_group.size
      date_average_time = formatted_duration average_time
    end

    respond_to do |format|
        format.js {}
        format.json { render :json => {
                                 :log_day_data => log_day_data,
                                 :log_day_dates => log_day_dates,
                                 :date_average => visitors_date_average,
                                 :average_time => date_average_time
                             }
        }
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
    @tab_name = 'Statistic'
  end
end
