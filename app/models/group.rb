class Group < ActiveRecord::Base
  has_many :tweets
  
  def inc
    self.update_attribute(:count, self.count + 1)
  end
  
  def dec
    if self.count == 1 # if it's the last one in its group, delete the group; otherwise, decrement the group count
      self.delete
    else
      self.update_attribute(:count, self.count - 1)
    end
  end
end