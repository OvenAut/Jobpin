class Pin < ActiveRecord::Base
  validates_presence_of :company , :title, :description
  
  def self.search(search_for)
    
    if search_for
      where('company LIKE ?', "%#{search_for}%")
    else
      scoped
    end
  end
end
