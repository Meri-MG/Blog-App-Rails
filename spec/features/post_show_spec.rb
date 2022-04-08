require 'rails_helper'

# rubocop:disable Metrics/BlockLength

RSpec.feature 'Users', type: :system do
  describe 'Show Page' do
    let!(:post) do
      visit new_user_session_path
      user = User.create(
        name: 'Meri',
        id: 1,
        email: 'meri2@example.com',
        password: 'password',
        posts_counter: 4,
        confirmed_at: Time.now
      )
      post = Post.create(
        author: user,
        title: 'my post',
        text: 'my post text',
        likes_counter: 8,
        comments_counter: 6
      )

      @comment = Comment.create(text: 'my comment', author: user, post: post)

      8.times { |_like| Like.create(author_id: user) }

      fill_in 'user_email', with: 'meri2@example.com'
      fill_in 'user_password', with: 'password'
      click_button 'Log in'
      visit "/users/#{user.id}"
      visit user_path(user)
      click_link 'Show all posts'
      click_link 'my post text'
      post
    end

    it "should have post's title, author" do
      expect(page).to have_content(post.title)
      page.should have_content('Meri')
    end

    it 'should check posts text' do
      page.should have_content('my post text')
    end

    it 'should check posts likes' do
      page.should have_content(8)
    end

    it 'should check posts comments' do
      page.should have_content(7)
    end

    it 'should check comments author' do
      comment = post.comments.first
      expect(page).to have_content(comment.author.name)
    end

    it 'should check comments text' do
      comment = post.comments.first
      expect(page).to have_content(comment.text)
    end
  end
end

# rubocop:enable Metrics/BlockLength
