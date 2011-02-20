# == Schema Information
# Schema version: 20110201031152
#
# Table name: microposts
#
#  id         :integer(4)      not null, primary key
#  content    :string(255)
#  user_id    :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

class Micropost < ActiveRecord::Base
  attr_accessible :content
  belongs_to :user
  validates :content, :presence => true,  :length => { :maximum => 140}
  validates :user_id, :presence => true
  
  # Ordering the microposts with 'default_scope'
  default_scope  :order => 'microposts.created_at  DESC'  
  
  
end
