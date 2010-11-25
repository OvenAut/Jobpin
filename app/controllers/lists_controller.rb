class ListsController < ApplicationController
  respond_to :json
  
  def index
    respond_with(@lists = Pin.search(params[:search_for]) , :only =>[:latitude, :longitude, :title, :id])
  end

  def show
    respond_with(@list = Pin.find(params[:id]))
  end

  def edit
    respond_with(@list = Pin.find(params[:id]))
  end


end
