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
      includes("geodatapin").where('company LIKE ?', "%#{search_for}%")
      #find_by_sql()
    else
      all #scoped
    end
  end
end
