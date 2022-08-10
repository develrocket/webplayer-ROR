class Backend::Client::AgentBrandingController < ApplicationController
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

    params[:agent_info][:company_id] = 0 if params[:agent_info][:company_id].blank?

    respond_to do |format|
      if @tour.admin.update_attributes(admin_params) and @tour.admin.agent_info.update_attributes(agent_info_params)
        @tour.agent_branding.update(avatar: params[:agent_branding][:avatar]) if params[:agent_branding] && params[:agent_branding][:avatar]

        # format.html { redirect_to agent_branding_index_path, notice: 'Tour Agent Branding was successfully updated.' }
        format.json { render json: {name:'Tour Agent Branding was successfully updated.'}, status: :ok}
      else
        # format.html { redirect_to agent_branding_index_path, notice: @tour.errors }
        format.json { render json: @tour.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  def get_tour_by_id!
    if params[:id]
      @tour = Tour.find(params[:id])
      @store_path = store_agent_branding_path(params[:id])
    else
      @tour = @tours[0]
      if @tour.blank?
        respond_to do |format|
          format.html { render 'backend/client/blank' }
          format.json
        end
      else
        @store_path = store_agent_branding_path(@tours[0].id)
      end
    end
    @tab_name = 'Agent Branding'
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
        :company_id
    )
  end
end
