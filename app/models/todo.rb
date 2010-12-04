# == Schema Information
# Schema version: 20101126025257
#
# Table name: todos
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  finished   :boolean
#  defect     :boolean
#  body       :text
#  due        :date
#  created_at :datetime
#  updated_at :datetime
#

class Todo < ActiveRecord::Base
    validates_presence_of :name
end
