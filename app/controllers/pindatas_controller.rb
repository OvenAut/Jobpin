class PindatasController < ApplicationController
  
  before_filter :authenticate_user!, :except => [:show, :index]
  # GET /pins/map
  
  #respond_to :json, :html
  

  
  def show_on_map
    #@pin = Pin.find(params[:id])
    #respond_to do |format|
      #format.html do
        
      #end
      #format.xml {
        render :text=>@pin.to_xml(
        :only =>[:latitude, :longitude, :title, :description],
        :root =>"data")
          #}
    #end
    
  end

  # GET /pins
  # GET /pins.xml
  def index
  @pindata = Pindata.search(params[:search_for])
  lookfor = ""
  #@lists = Pindata.new
  #respond_with(@lists = Pindata.includes("geodatapin").search(params[:search_for]) , :only =>[:latitude, :longitude, :company, :id])
  #lookfor = "WHERE pindatas.company LIKE %'#{params[:search_for]}'%" if  (params[:search_for])
  #lookfor = where('company LIKE ?', "%#{params[:search_for]}%")
  lookfor = "WHERE pindatas.company LIKE '%#{params[:search_for]}%'" if  (params[:search_for])
  @pindata2 = Pindata.find_by_sql(" SELECT *  FROM pindatas
    INNER JOIN geodatapins ON geodatapins.pindata_id = pindatas.id #{lookfor} ")
  #puts @lists.inspect
  #respond_with(@pins)
    #j = ActiveSupport::JSON
    #lists = j.encode(pins)
    
    #respond_with(lists)
    #respond_with do |format|
      #format.html   
      #format.js {render :json => @pins}
    #end
    
  end

  # GET /pins/1
  # GET /pins/1.xml
  def show
   @pindata = Pindata.find(params[:id])
   
    # ActiveRecord::Base.include_root_in_json = true
#    respond_with(@pin)
  pins_id = (params[:id])
  @pindata2 = Pindata.find_by_sql("SELECT *  FROM pindatas
  INNER JOIN geodatapins ON geodatapins.pindata_id = pindatas.id
  WHERE pindatas.id = (#{pins_id}) ")
  #puts @pindata.inspect

  end

  # GET /pins/new
  # GET /pins/new.xml
  def new
    @pin = Pin.new

        @pin.latitude=params['latitude']
        @pin.longitude=params['longitude']
        render :partial => "new", :locals=>{:pin=>@pin}

      #format.js
  end

  # GET /pins/1/edit
  def edit
    @pin = Pin.find(params[:id])
  #  respond_with(@pins)
    
  end

  # POST /pins
  # POST /pins.xml
  def create
    @pin = Pin.new(params[:pin])


      if @pin.save
        redirect_to(@pin,:notice => 'Pin was successfully created.')
        #redirect_to(@pin,:notice => 'Pin was successfully created.')
 #       format.xml  { render :xml => @pin, :status => :created, :location => @pin }
      else
        render :action => "new"
  #      format.xml  { render :xml => @pin.errors, :status => :unprocessable_entity }
        
      end
  end

  # PUT /pins/1
  # PUT /pins/1.xml
  def update
    @pin = Pin.find(params[:id])
    
#    respond_to do |format|
      if @pin.update_attributes(params[:pin])
        redirect_to(@pin, :notice => 'Pin was successfully updated.')
   #     format.xml  { head :ok }
      else
        render :action => "edit"
    #    format.xml  { render :xml => @pin.errors, :status => :unprocessable_entity }

      end
#    end
  end

  # DELETE /pins/1
  # DELETE /pins/1.xml
  def destroy
    @pin = Pin.find(params[:id])
    @pin.destroy
      redirect_to(pins_url)
     # format.xml  { head :ok }
    end
  
end
