class Backend::Client::DisplayContentController < ApplicationController
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
      if @tour.display_option.update_attributes(display_option_params)

        # format.html { redirect_to display_content_index_path, notice: 'Tour Display Contents was successfully updated.' }
        format.json { render json: {name:'Tour Display Contents was successfully updated.'}, status: :ok}
      else
        # format.html { redirect_to display_content_index_path, notice: @tour.errors }
        format.json { render json: @tour.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  def get_tour_by_id!
    if params[:id]
      @tour = Tour.find(params[:id])
      @store_path = store_display_content_path(params[:id])
    else
      @tour = @tours[0]
      if @tour.blank?
        respond_to do |format|
          format.html { render 'backend/client/blank' }
          format.json
        end
      else
        @store_path = store_display_content_path(@tours[0].id)
      end
    end
    @tab_name = 'Display Contents'
  end

  def display_option_params
    params.require(:display_option).permit(
        :show_aerial,
        :show_birds_eye,
        :show_exterior_walkin,
        :show_detach_unit,
    )
  end
end
