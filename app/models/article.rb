class Article < ActiveRecord::Base
  belongs_to :user

  scope :chronological, order: 'articles.created_at ASC'
  scope :of, (lambda do |current_user| 
    {conditions: ['articles.user_id = ?', current_user]}
  end)
  scope :for_index, select: [:id, :title]
  
  self.per_page = 10
  
  validates_presence_of :title
  validates_presence_of :body
  validates_presence_of :user_id
  
end