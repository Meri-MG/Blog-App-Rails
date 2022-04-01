class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :likes
  has_many :comments
  validates :title, presence: true, length: { minimum: 3, maximum: 250 }
  validates :comments_counter, numericality: { only_integer: true }, comparison: { greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true }, comparison: { greater_than_or_equal_to: 0 }

  after_create :update_posts_count

  def five_recent_comments
    comments.order('created_at DESC').limit(5)
  end

  private

  def update_posts_count
    author.increment!(:posts_counter)
  end
end
