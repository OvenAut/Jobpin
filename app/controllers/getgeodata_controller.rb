class GetgeodataController < ApplicationController
  #
  # Table name: employments
  #
  #  id         :integer         not null, primary key
  #  name       :string(255)
  #  created_at :datetime
  #  updated_at :datetime
  #
  #
  # Table name: occupations
  #
  #  id         :integer         not null, primary key
  #  name       :string(255)
  #  created_at :datetime
  #  updated_at :datetime
  #
  #
  # Table name: pindatas
  #
  #  id            :integer         not null, primary key
  #  body          :text
  #  company       :string(255)
  #  joblocation   :string(255)
  #  education     :string(255)
  #  occupation_id :integer
  #  employment_id :integer
  #  created_at    :datetime
  #  updated_at    :datetime
  #
  #
  # Table name: geodatapins
  #
  #  id                :integer         not null, primary key
  #  formatted_address :string(255)
  #  lat               :float
  #  lng               :float
  #  pindata_id        :integer
  #  created_at        :datetime
  #  updated_at        :datetime
  #
  #
  # Table name: syspindatas
  #
  #  id         :integer         not null, primary key
  #  sitesrcid  :string(255)     default(""), not null
  #  dataurl    :string(255)
  #  datasrc    :string(255)
  #  geocook    :boolean
  #  pindata_id :integer
  #  created_at :datetime
  #  updated_at :datetime
  #  

    before_filter :authenticate_user!
    before_filter :admin_user, :only => :index


  def index
    @web_pindata = Pindata.new
    @web_geodatapin = Geodatapin.new
    @web_employment = Employment.new
    @web_occupation = Occupation.new
    @web_syspindata = Syspindata.new
    @web_geodatapin2 = Geodatapin.new
    #@google_geo = Geocood.new
    #Cravdata.find_or_create_by_siteid(web)

    @loopstatus = true
    @status = "Negative" 
    @statustext = params[:getdata][:address]
    
    action
    redirect_to(root_path, :notice => "Cravdata !.#{@status} von #{@statustext}")

  end
  
private

# class Geocood 
# 
#    attr_accessor :lat , :geocook
#    attr_accessor :lng
#    attr_accessor :address
#   
#       def getgeocode!(address,sublocation)
#      #puts address
#      #puts sublocation
#      #attr :lat ,:lng ,:address
#      
#      @geocook = false
#       f = Net::HTTP.get_response(URI.parse(URI.encode("http://maps.google.com/maps/api/geocode/json?address=#{address} #{sublocation}&sensor=false")))
#      
#      json = ActiveSupport::JSON.decode(f.body)
#      @lat = json["results"][0]["geometry"]["location"]["lat"]
#      @lng = json["results"][0]["geometry"]["location"]["lng"]
#      @address  = json["results"][0]["formatted_address"]
#      @geocook = true
#       rescue
#      #puts "hello"
#      @geocook = false
#      
#        #false # For now, fail silently...
#       end
# 
# end


  def admin_user
    

    redirect_to(root_path) if !current_user.admin?
  
    
  end
  

  def updatestats()
    @web_pindata.valid_pin = true
    #@loopstatus = false
    # puts @web_geodatapin.lat
    # puts @web_geodatapin.lng
    # puts @web_occupation.name
    @data = Occupation.find_by_name(@web_occupation.name)
    #puts (@data.to_a).id
    if @data
      @web_pindata.occupation_id = @data.id.to_i
    else
      @data2 = Occupation.new(:name => @web_occupation.name)
      puts @data2.inspect
      if @data2.save
        @web_pindata.occupation_id = @data2.id.to_i
      else
        @web_pindata.occupation_id = nil
        @status = "occupation not fund"
        @web_pindata.valid_pin = false
        
      end      
    end
    
    puts "employment"
    
      @data = Employment.find_by_name(@web_employment.name.to_s)
      #puts (@data.to_a).id
      if @data
        @web_pindata.employment_id = @data.id.to_i
      else
        @data2 = Employment.new(:name => @web_employment.name)
        # puts @data2.inspect

        if @data2.save
          @web_pindata.employment_id = @data2.id.to_i
        else
          @web_pindata.employment_id = nil
          @status = "employment not fund"
          @web_pindata.valid_pin = false           
        end
    
      end
    
    
    if @web_pindata.valid_pin
      
      
      data_pindata = Pindata.new(:body => @web_pindata.body,         
          :company => @web_pindata.company,       
          :joblocation => @web_pindata.joblocation,
          :education => @web_pindata.education,
          :occupation_id => @web_pindata.occupation_id,
          :employment_id => @web_pindata.employment_id,
          :valid_pin => @web_pindata.valid_pin
      )
    
    
    if data_pindata.save
      #puts @web_geodatapin.lat
      #puts @web_geodatapin.lng
      
      @web_geodatapin.pindata_id = data_pindata.id.to_i
      data_geodatapin = Geodatapin.new(:formatted_address => @web_geodatapin.formatted_address,         
          :lat => @web_geodatapin.lat,       
          :lng => @web_geodatapin.lng,
          :pindata_id => @web_geodatapin.pindata_id
      )
    
        if data_geodatapin.save
          @web_syspindata.pindata_id = data_pindata.id.to_i
          data_syspindata = Syspindata.new(:sitesrcid => @web_syspindata.sitesrcid,
          :dataurl => @web_syspindata.dataurl,
          :datasrc => @web_syspindata.datasrc,
          :geocook => @web_syspindata.geocook,
          :pindata_id => @web_syspindata.pindata_id)
            
        if data_syspindata.save
            @loopstatus = true
        else
          @status = "web_geodatapin not saved"
        end
      
        else
          @status = "web_geodatapin not saved"
        end
      
       else
             #web_pindata not saved
      @status = "web_pindata not saved"
    end
    
  
    else
            @status = "pindata not valid"
    end
    # if Cravdata.find_by_siteid(web.siteid.to_s)
    #   return
    # else
    #   Cravdata.create(:siteid => @web.siteid.to_s,
    #     :dataurl=>web.dataurl.to_s, 
    #     :datasrc => @web.datasrc.to_s, 
    #     :state => @web.state.to_s,
    #     :address => @web.address.to_s, 
    #     :lat => @web.lat, 
    #     :lng => @web.lng, 
    #     :body => @web.body,
    #     :company => @web.company.text.to_s,
    #     :employmentwork => @web.employmentwork.text.to_s, 
    #     :occupationgroup => @web.occupationgroup.text.to_s,
    #     :joblocation => @web.joblocation.text.to_s,
    #     :employmenttype => @web.employmenttype.text.to_s,
    #     :education => @web.education.text.to_s)
    # end


  end




  def action

    #@web.dataurl = "action"
    @status = "Finishd" 
    
    agent = Mechanize.new


    agent.user_agent_alias = 'Mac Safari'
    agent.user_agent ='invidueller User'
    agent.open_timeout = 3
    agent.read_timeout = 4
    agent.keep_alive = false

    url = 'http://jobroom.ams.or.at/jobsuche/'
    urlplus = url.to_s + 'FreieSuche.jsp'
    #puts urlplus
    agent.get(urlplus)

    #agent.get("http://jobroom.ams.or.at/jobsuche/FreieSuche.jsp")


    form = agent.page.forms.first
    form.query = @statustext
    form.submit




    pagesmax = ((agent.page.search("b:nth-child(3)").text.to_i)/10).to_i
    pagesmax.floor
    #puts pagesmax 

    #agent.page.links.each do |link|
    #  puts link.to_s
    #  if link.text =~ /Vorwärts/ 
    #    puts link.inspect
    #  end
    #end


   pagesmax.times do
   #1.times do

     
    agent.page.links_with(:href => /index=/).each do |link|# if @loopstatus == true
      if @loopstatus == true
      
      link.click
      #matchval =/[^\n?\r?]([A-Z]\w*\b?[^\n?\r?]\S*\s?[1-9]+\/?-*[1-9]*\/?[1-9]*)(?=,?\s*.{0,3}(?i:1020 Wien))/
      matchval =/[^\n\r,:;.\b ](\w*\ ?[^\n\r,:;.]\S+\ \d+\/?-?\d*\/?\d*[a-z]?)(?= ?,?.?\s*\.{0,3}(?i:#{form.query}))/
      matchval =/[^\n\r,:;.\b ](\w*\ ?[^\n\r,:;.]\S+\ \d+\/?-?\d*\/?\d*[a-z]?)(?= ?,?.?\s*\.{0,3}(?i:#{form.query}))/
      
      matchval2 = /(\d{7,}_\d{1,3})/
      matchstring = agent.page.search('td.tdcontent')
      matchstring.search('br').each{ |br| br.replace(Nokogiri::XML::Text.new("\n", matchstring.document))}
      match_data = link.href.to_s.match(matchval2)
        if (agent.page.search('td.tdcontent').text =~ /S+/ && matchstring.text.match(matchval)&& (Syspindata.find_by_sitesrcid(match_data.to_s)).blank? )
        #puts matchstring
        #&& Syspindata.find_by_sitesrcid(match_data)== false
        address = matchstring.text.match(matchval)
        
        @web_syspindata.dataurl = url.to_s + link.href.to_s
        @web_syspindata.datasrc = "AMS"
        @web_syspindata.sitesrcid = (link.href.to_s.match(matchval2)).to_s
        #@web.state = form.query
        @web_pindata.body = agent.page.search('td.tdcontent').text

        # f = Net::HTTP.get_response(URI.parse(URI.encode("http://maps.google.com/maps/api/geocode/json?address=#{@web.address} #{form.query}&sensor=false")))
        # json = ActiveSupport::JSON.decode(f.body)
        # @web.lat = json["results"][0]["geometry"]["location"]["lat"]
        # @web.lng = json["results"][0]["geometry"]["location"]["lng"]
        
        #@google_geo.getgeocode!(address,form.query)
        #@web_geodatapin2.getgeocode!(address,form.query)
        # def getgeocode!(address,sublocation)
        #puts address
        #puts sublocation
        #attr :lat ,:lng ,:address
        #puts "i wa hier ::::::::::::::::_--------"
        @web_syspindata.geocook = false
        f = Net::HTTP.get_response(URI.parse(URI.encode("http://maps.google.com/maps/api/geocode/json?address=#{address} #{form.query}&sensor=false")))

        json = ActiveSupport::JSON.decode(f.body)
        @web_geodatapin.lat = json["results"][0]["geometry"]["location"]["lat"]
        @web_geodatapin.lng = json["results"][0]["geometry"]["location"]["lng"]
        if (json['status'] != "OK") 
              @loopstatus = false 
        end
        @web_geodatapin.formatted_address  = json["results"][0]["formatted_address"]
        @web_syspindata.geocook = true
        #puts @lat
         #rescue
        #puts "hello"
        #@geocook = false

          #false # For now, fail silently...
        
        
# = @web#_geodatapin2.lat
        #@web_geodatapin.lng = @web_geodatapin2.lng
        #@web_geodatapin.formatted_address = @web_geodatapin2.formatted_address #@google_geo.address
        #@web_syspindata.geocook = @web_geodatapin.geocook
        
        @web_pindata.company = agent.page.search('tr:nth-child(2) .fld:nth-child(2)').text
        @web_employment.name = agent.page.search('.tdcontent tr:nth-child(3) .fld').text
        @web_occupation.name = agent.page.search('tr:nth-child(4) .fld').text
        @web_pindata.joblocation = agent.page.search('tr:nth-child(5) .fld').text
        @web_employment.name = agent.page.search('tr:nth-child(6) .fld').text
        @web_pindata.education = agent.page.search('.tdcontent tr:nth-child(7) .fld').text
        #puts @web_occupation.name
        #puts "before update"
        updatestats()
        
        
        
        # puts @web_pindata.inspect
        #         puts "@web_pindata.inspect"
        #         
        #         puts @web_geodatapin.inspect
        #         puts "@web_geodatapin.inspect"
        #         puts @web_employment.inspect
        #         puts "@web_employment.inspect"
        #         puts @web_occupation.inspect
        #         puts "@web_occupation.inspect"
        #         puts @web_syspindata.inspect
        #         puts "@web_syspindata.inspect"
        #         
        # #puts @google_geo.inspect


        
        
        end
      
    end
    
    
  end
    if agent.page == nil
      @loopstatus = false
    end
      if @loopstatus == true
          10.times {agent.back}

          agent.page.links.find{ |l| l.text =~ /Vorw.?rts/}.click


      end
   end
  end

end
