class PinsController < ApplicationController
  # GET /pins/map

  
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
    
  @pins = Pin.search(params[:search_for])
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
    @pin = Pin.find(params[:id])
    respond_to do |format|
      format.html { }
      format.xml  { render :text=>@pin.to_xml(
      :only =>[:latitude, :longitude, :title, :description],
      :root =>"data") }
    end
  end

  # GET /pins/new
  # GET /pins/new.xml
  def new
    @pin = Pin.new

    respond_to do |format|
      format.html {
        @pin.latitude=params['latitude']
        @pin.longitude=params['longitude']
        render :partial => "new", :locals=>{:pin=>@pin}
      }
      format.xml  { render :xml => @pin }
      #format.js
    end
  end

  # GET /pins/1/edit
  def edit
    @pin = Pin.find(params[:id])
    
  end

  # POST /pins
  # POST /pins.xml
  def create
    @pin = Pin.new(params[:pin])

    respond_to do |format|
      if @pin.save
        format.html { redirect_to(@pin,:notice => 'Pin was successfully created.')}
        #redirect_to(@pin,:notice => 'Pin was successfully created.')
        format.xml  { render :xml => @pin, :status => :created, :location => @pin }
        format.js
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @pin.errors, :status => :unprocessable_entity }
        
      end
    end
  end

  # PUT /pins/1
  # PUT /pins/1.xml
  def update
    @pin = Pin.find(params[:id])

    respond_to do |format|
      if @pin.update_attributes(params[:pin])
        format.html { redirect_to(@pin, :notice => 'Pin was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @pin.errors, :status => :unprocessable_entity }
        
      end
    end
  end

  # DELETE /pins/1
  # DELETE /pins/1.xml
  def destroy
    @pin = Pin.find(params[:id])
    @pin.destroy

    respond_to do |format|
      format.html { redirect_to(pins_url) }
      format.xml  { head :ok }
    end
  end
end
