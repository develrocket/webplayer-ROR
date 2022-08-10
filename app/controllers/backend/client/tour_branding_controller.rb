class Backend::Client::TourBrandingController < ApplicationController
  layout 'application_admin'
  before_action :authenticate_admin!, :check_permission_for_client!, :get_tours
  def index
    get_tour_by_id!

    respond_to do |format|
      format.html{ render :layout => false }
    end
  end
  def store
    get_tour_by_id!

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

  private
  def get_tour_by_id!
    if params[:id]
      @tour = Tour.find(params[:id])
      @store_path = store_tour_branding_path(params[:id])
    else
      @tour = @tours[0]
      if @tour.blank?
        respond_to do |format|
          format.html { render 'backend/client/blank' }
          format.json
        end
      else
        @store_path = store_tour_branding_path(@tours[0].id)
      end
    end
    @tab_name = 'Tour Branding'
  end

  def tour_branding_params
    params.require(:tour_branding).permit(:logo_width, :logo_height, :is_logo_show)
  end
end
