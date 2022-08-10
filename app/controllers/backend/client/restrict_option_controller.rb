class Backend::Client::RestrictOptionController < ApplicationController
  before_action :authenticate_admin!, :check_permission_for_client!, :get_tours
  layout 'application_admin'
  def index
    get_tour_by_id!

    respond_to do |format|
      format.html{ render :layout => false }
    end
  end
  def store
    get_tour_by_id!
    restrict_option = @tour.restrict_option
    check_restriction_level restrict_option
    respond_to do |format|
      if @tour.restrict_option.update_attributes(restrict_options_params)
        # format.html { redirect_to restrict_option_index_path, notice: 'Tour Restrict Option was successfully updated.' }
        format.json { render json: {name:'Tour Restrict Option was successfully updated.'}, status: :ok}
      else
        # format.html { redirect_to restrict_option_index_path, notice: @tour.errors }
        format.json { render json: @tour.errors, status: :unprocessable_entity }
      end
    end

  end
  def restrict_options_params
    params.require(:restrict_option).permit(
        :email,
        :email_confirmation,
        :name,
        :message,
        :phone,
        :agent_approval,
        :send_inquire,
        :walkintour,
        :google45_imagery,
        :restrict_on,
        :review_seconds
    )
  end

  private
  def get_tour_by_id!
    if params[:id]
      @tour = Tour.find(params[:id])
      @store_path = store_restrict_option_path(params[:id])
    else
      @tour = @tours[0]
      if @tour.blank?
        respond_to do |format|
          format.html { render 'backend/client/blank' }
          format.json
        end
      else
        @store_path = store_restrict_option_path(@tours[0].id)
      end
    end
    @tab_name = 'Restrict Options'
  end
end
