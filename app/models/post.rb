class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :likes
  has_many :comments

  after_create :update_posts_count

  def five_recent_comments
    comments.order('created_at DESC').limit(5)
  end

  private

  def update_posts_count
    author.increment!(:posts_counter)
  end
end
