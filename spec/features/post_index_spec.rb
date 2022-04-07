require 'rails_helper'

RSpec.feature "Users", type: :system do
  describe 'Show Page' do 
    let!(:user) do
      visit new_user_session_path
      user = User.create(
      name: 'Meri',
      id: 1,
      email: 'meri2@example.com',
      password: 'password',
      posts_counter: 4,
      confirmed_at: Time.now
    )
      Post.create(
        author: user,
        title: 'my post',
        text: 'my post text',
        likes_counter: 8,
        comments_counter: 6
      )
    6.times { |comment| Comment.create(author: user, text: 'my comment') }

    8.times { |like| Like.create(author: user) }

    fill_in 'user_email', with: 'meri2@example.com'
    fill_in 'user_password', with: 'password'
    click_button 'Log in'
    visit '/users/#{user.id}'
    click_link user.posts_counter
    visit user_path(user)
    click_link 'Show all posts'
    user
  end

    it "should check the content of user attributes on the page" do
      expect(page).to have_content(user.name)
      expect(page).to have_content(user.bio)
      expect(Post.count).to eq 1
      page.should have_selector('img')
    end

    it "should check the content of post and comment" do
      page.should have_content('my post text')
      posts = user.posts
        posts.each do |post|
          post.five_recent_comments.each do |comment|
            expect(page).to have_content(comment.text)
          end
        end
    end

    it "should check the likes counter" do
      posts = user.posts
      posts.each do |post|
        expect(page).to have_content(post.likes_counter)
      end
    end

    it "should check the comments counter" do
      posts = user.posts
      posts.each do |post|
        expect(page).to have_content(post.comments_counter)
      end
    end

    it "should click on post and direct to the post show page" do
      click_link 'my post text'
      posts = user.posts
      posts.each do |post|
        expect(page).to have_current_path user_post_path(user.id, post.id)
      end
    end
  end
end
