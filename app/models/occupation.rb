# == Schema Information
# Schema version: 20101202210103
#
# Table name: occupations
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Occupation < ActiveRecord::Base
  has_many :pindatas
  has_and_belongs_to_many :geodatapin
  has_and_belongs_to_many :syspindata
  
  validates_presence_of :name
  
end
