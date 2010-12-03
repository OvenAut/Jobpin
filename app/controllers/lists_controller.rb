class ListsController < ApplicationController
  respond_to :json
  
  def index
    lookfor = ""
    #@lists = Pindata.new
    #respond_with(@lists = Pindata.includes("geodatapin").search(params[:search_for]) , :only =>[:latitude, :longitude, :company, :id])
    #lookfor = "WHERE pindatas.company LIKE %'#{params[:search_for]}'%" if  (params[:search_for])
    #lookfor = where('company LIKE ?', "%#{params[:search_for]}%")
    lookfor = "WHERE pindatas.company LIKE '%#{params[:search_for]}%'" if  (params[:search_for])
    respond_with(@lists = Pindata.find_by_sql(" SELECT *  FROM pindatas
      INNER JOIN geodatapins ON geodatapins.pindata_id = pindatas.id #{lookfor} ") , :only =>[:lat, :lng, :company, :id ,:education])
    #puts @lists.inspect  
  end

  def show
    #respond_with(@list = Pindata.find(params[:id]))
    pins_id = (params[:id])
    respond_with(@lists = Pindata.find_by_sql("SELECT *  FROM pindatas
      INNER JOIN geodatapins ON geodatapins.pindata_id = pindatas.id
      WHERE pindatas.id = (#{pins_id}) " ), :only => [:company, :joblocation, :education, :id, :lat, :lng] )
      #puts (params[:id]).inspect
  end

  def edit
    respond_with(@list = Pindata.find(params[:id]))
  end

end


