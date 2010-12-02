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
end
