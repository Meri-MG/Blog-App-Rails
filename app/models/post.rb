class Post < ApplicationRecord
  belongs_to :author, :class_name => "User"
  has_many :likes, :class_name => "Like"
  has_many :comments, :class_name => "Comment"

  after_create :update_users_count

  def update_users_count
    author = User.find(self.author_id)
    author.increment(:posts_counter)
  end

  def five_recent_comments
    Comment.order('created_at DESC').limit(5)
  end
end
