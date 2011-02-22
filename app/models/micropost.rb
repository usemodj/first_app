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
  
#  def self.from_users_followed_by( user)
#    #    (Here we’ve used the Rails convention of user instead of user.id in the condition;
#    #    Rails automatically uses the id. We’ve also omitted the leading Micropost. since we
#    #    expect this method to live in the Micropost model itself.)
#
#    followed_ids = user.following.map(&:id).join(", ")
#    where( "user_id IN (#{followed_ids}) OR user_id = ?", user)
#  end
  #Return microposts from the users being followed by the given user.
  scope  :from_users_followed_by,  lambda {|user| followed_by( user)}
    
  private
  
  # Return an SQL condition for users followed by the given user.
  # We include the user's own id as well
  #  SELECT * FROM microposts
  #  WHERE user_id IN (SELECT followed_id FROM relationships
  #  WHERE follower_id = 1)
  #  OR user_id = 1

  def self.followed_by( user)
    # followed_ids = user.following.map(&:id).join(", ")
    followed_ids = %(SELECT followed_id FROM relationships WHERE follower_id = :user_id)
    where("user_id IN (#{followed_ids}) OR user_id = :user_id", { :user_id => user})
  end
end
