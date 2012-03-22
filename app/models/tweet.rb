class Tweet < ActiveRecord::Base
  belongs_to :hash_tag
  belongs_to :group
  belongs_to :user
  
  # always eager load hash_tag/group info and order tweets by created at timestamp
  default_scope include: [:hash_tag, :group], order: 'tweets.created_at DESC'
  scope :of, (lambda do |current_user| 
    {conditions: ['tweets.user_id = ? AND hash_tags.user_id = ?', current_user, current_user]}
  end)
  
  self.per_page = 6
  
  validates_presence_of :tweet
  validates_presence_of :hash_tag_id
  validates_presence_of :group_id
  validates_presence_of :user_id
  
  def length # of 'tweet #hashtag'
    self.to_s.length + self.hash_tag.to_s.length + 2
  end
  
  def related
    self.group.tweets
  end
  
  def related_count
    self.group.count
  end
  
  def to_s # of just tweet
    self.tweet
  end
end