# == Schema Information
# Schema version: 20101202210103
#
# Table name: employments
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Employment < ActiveRecord::Base
  has_many :pindatas
  has_and_belongs_to_many :geodatapin
  has_and_belongs_to_many :syspindata
end
