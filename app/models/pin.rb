# == Schema Information
# Schema version: 20101126025257
#
# Table name: pins
#
#  id          :integer         not null, primary key
#  company     :string(255)
#  latitude    :decimal(, )
#  longitude   :decimal(, )
#  title       :string(255)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#

class Pin < ActiveRecord::Base
  validates_presence_of :company , :title, :description
  
  def self.search(search_for)
    
    if search_for
      where('company LIKE ?', "%#{search_for}%")
    else
      all #scoped
    end
  end
end
