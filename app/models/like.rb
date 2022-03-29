class Like < ApplicationRecord
  belongs_to :author, :class_name => "User"
  belongs_to :post, :class_name => "Post"

  after_create :update_likes_count

  def update_likes_count
    post = Post.find(self.post_id)
    post.increment(:likes_counter)
  end
end