class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post, class_name: 'Post'

  after_create :update_comments_count

  def update_comments_count
    post = Post.find(post_id)
    post.increment(:comments_counter)
  end
end
