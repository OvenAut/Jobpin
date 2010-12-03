# == Schema Information
# Schema version: 20101202210103
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

class Geodatapin < ActiveRecord::Base
  belongs_to :pindata
  has_one :employment, :through => :pindata
  has_one :occupation, :through => :pindata
  has_one :syspindata, :through => :pindata
  
  validates_presence_of :formatted_address, :lat, :lng, :pindata_id
  validates_numericality_of :lat ,:lng



     attr_accessor :lat , :geocook ,:lng, :formatted_address



        def getgeocode!(address,sublocation)
       #puts address
       #puts sublocation
       #attr :lat ,:lng ,:address
       #puts "i wa hier ::::::::::::::::_--------"
       @geocook = false
        f = Net::HTTP.get_response(URI.parse(URI.encode("http://maps.google.com/maps/api/geocode/json?address=#{address} #{sublocation}&sensor=false")))

       json = ActiveSupport::JSON.decode(f.body)
       self.lat = json["results"][0]["geometry"]["location"]["lat"]
       self.lng = json["results"][0]["geometry"]["location"]["lng"]
       self.formatted_address  = json["results"][0]["formatted_address"]
       self.geocook = true
       #puts @lat
        rescue
       #puts "hello"
       @geocook = false

         #false # For now, fail silently...
        end




end
