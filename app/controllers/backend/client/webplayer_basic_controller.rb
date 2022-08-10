class Backend::Client::WebplayerBasicController < ApplicationController
  before_action :authenticate_admin!, :check_permission_for_client!, :get_tours
  layout 'application_admin'
  def index
    # geo_result = request.location
    #
    # begin
    #   # timezone = Timezone::Zone.new :latlon => [geo_result.latitude, geo_result.longitude]
    #   current_admin.latitude = geo_result.latitude
    #   current_admin.longitude = geo_result.longitude
    # rescue
    #   current_admin.latitude = 0.0
    #   current_admin.longitude = 0.0
    # end
    # current_admin.save

    get_tour_by_id!
  end

  def index_ajax
    get_tour_by_id!
    respond_to do |format|
      format.html { render 'backend/client/webplayer_basic/_webplayer_basic', :layout => false }
    end
  end

  def store
    get_tour_by_id!

    @tour.webplayer_basic.update_attributes(webplayer_basic_params)

    respond_to do |format|
      format.html { redirect_to webplayer_basic_index_path, notice: 'Tour Webplayer Basic was successfully updated.' }
      format.json { render json: webplayer_basic_index_path, status: :updated, location: @tour }
    end
  end

  private

  def get_tour_by_id!
    if params[:id]
      @tour = Tour.find(params[:id])
      @store_path = store_webaplyer_basic_path(params[:id])
    else
      @tour = @tours[0]
      if @tour.blank?
        respond_to do |format|
          format.html { render 'backend/client/blank' }
          format.json
        end
      else
        @store_path = store_webaplyer_basic_path(@tours[0].id)
      end
    end
    @tab_name = 'Webplayer Basic'
  end

  def webplayer_basic_params
    params.require(:webplayer_basic).permit(:tour_address, :matterport_link, :height, :width, :exterior_link,
                                            :is_media_show, :brand_width, :brand_height, :media_width, :media_height)
  end
end
