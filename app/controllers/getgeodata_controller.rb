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


    before_filter :admin_user, :only => :index


  def index
    @web_pindata = Pindata.new
    @web_geodatapin = Geodatapin.new
    @web_employment = Employment.new
    @web_occupation = Occupation.new
    @web_syspindata = Syspindata.new
    #@google_geo = Geocood.new
    #Cravdata.find_or_create_by_siteid(web)


    status = "Fertig" 

    action
    redirect_to(root_path, :notice => "Cravdata !.#{status}")

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
    current_user.admin?
  end
  

  def updatestats()
    puts @web_geodatapin.lat
    puts @web_geodatapin.lng


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
    form.query = "1020 wien"
    form.submit




    pagesmax = (agent.page.search("b:nth-child(3)").text.to_i)/9
    #puts pagesmax 

    #agent.page.links.each do |link|
    #  puts link.to_s
    #  if link.text =~ /Vorwärts/ 
    #    puts link.inspect
    #  end
    #end


   1.times do



    agent.page.links_with(:href => /index=/).each do |link|

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

        #f = Net::HTTP.get_response(URI.parse(URI.encode("http://maps.google.com/maps/api/geocode/json?address=#{@web.address} #{form.query}&sensor=false")))
        #json = ActiveSupport::JSON.decode(f.body)
        #@web.lat = json["results"][0]["geometry"]["location"]["lat"]
        #@web.lng = json["results"][0]["geometry"]["location"]["lng"]
        
        #@google_geo.getgeocode!(address,form.query)
        @web_geodatapin.getgeocode!(address,form.query)
        #puts @web_geodatapin.lat
        #puts @web_geodatapin.lng
        #@web_geodatapin.formatted_address = nil #@google_geo.address
        @web_syspindata.geocook = @web_geodatapin.geocook
        
        @web_pindata.company = agent.page.search('tr:nth-child(2) .fld:nth-child(2)').text
        @web_employment.name = agent.page.search('.tdcontent tr:nth-child(3) .fld').text
        @web_occupation.name = agent.page.search('tr:nth-child(4) .fld').text
        @web_pindata.joblocation = agent.page.search('tr:nth-child(5) .fld').text
        @web_employment.name = agent.page.search('tr:nth-child(6) .fld').text
        @web_pindata.education = agent.page.search('.tdcontent tr:nth-child(7) .fld').text

        updatestats()

      end
    end
    10.times {agent.back}

     agent.page.links.find{ |l| l.text =~ /Vorw.?rts/}.click

   end
   
   puts @web_pindata.inspect
   puts "@web_pindata.inspect"
   
   puts @web_geodatapin.inspect
   puts "@web_geodatapin.inspect"
   puts @web_employment.inspect
   puts "@web_employment.inspect"
   puts @web_occupation.inspect
   puts "@web_occupation.inspect"
   puts @web_syspindata.inspect
   puts "@web_syspindata.inspect"
   #puts @google_geo.inspect

  end

end
