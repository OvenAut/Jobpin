# == Schema Information
# Schema version: 20101203024606
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
#  valid         :boolean
#

class Pindata < ActiveRecord::Base
  attr_accessor :valid_pin
  
  belongs_to :occupation, :dependent => :destroy 
  belongs_to :employment, :dependent => :destroy  
  has_one :syspindata, :dependent => :destroy 
  has_one :geodatapin, :dependent => :destroy 
  
  validates_presence_of :body, :occupation_id , :employment_id
  
  
  def set_valid_pin
    
  end
  def self.search(search_for)
    
    if search_for
      where('company LIKE ?', "%#{search_for}%")
      #find_by_sql()
    else
       all#scoped
    end
  end
  
  
end
