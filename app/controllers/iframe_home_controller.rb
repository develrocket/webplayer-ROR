class IframeHomeController < ApplicationController
  def index
    @tour = Tour.find(params[:id])
    render 'home/index'
  end
end
