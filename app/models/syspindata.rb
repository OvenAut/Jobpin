# == Schema Information
# Schema version: 20101202210103
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

class Syspindata < ActiveRecord::Base
  belongs_to :pindata, :dependent => :destroy 
  has_one :employment, :through => :pindata
  has_one :occupation, :through => :pindata
  has_one :geodatapin, :through => :pindata
  
end
