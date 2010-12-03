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



     #attr_accessor :lat , :geocook ,:lng, :formatted_address
#sitescid






end
