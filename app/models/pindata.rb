# == Schema Information
# Schema version: 20101202210103
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

class Pindata < ActiveRecord::Base
  belongs_to :occupation, :dependent => :destroy 
  belongs_to :employment, :dependent => :destroy  
  has_one :syspindata, :dependent => :destroy 
  has_one :geodatapin, :dependent => :destroy 
end
