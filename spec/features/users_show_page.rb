require 'rails_helper'

# rubocop:disable Metrics/BlockLength

RSpec.feature 'Users', type: :system do
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

      4.times do |_post|
        Post.create(
          author: user,
          title: 'my post',
          text: 'my post text',
          likes_counter: 0,
          comments_counter: 0
        )
      end
      fill_in 'user_email', with: 'meri2@example.com'
      fill_in 'user_password', with: 'password'
      click_button 'Log in'
      visit "/users/#{user.id}"
      user
    end

    it 'should check the content of user attributes on the page' do
      expect(page).to have_content(user.name)
      expect(page).to have_content(user.bio)
      expect(page).to have_content(user.posts_counter)
      page.should have_selector('img')
    end

    it 'should check the content of post attributes on the page' do
      click_link user.posts_counter
      expect(page).to have_current_path user_path(user.id)
      recent_posts = user.three_recent_posts
      recent_posts.each do |post|
        expect(page).to have_content(post.title)
      end
    end

    it "should check the show all posts button and it's interactions" do
      click_link user.posts_counter
      expect(page).to have_current_path user_path(user.id)
      expect(page).to have_content('Show all posts')
      click_link 'Show all posts'
      expect(page).to have_current_path('/users/1/posts')
    end
  end
end

# rubocop:enable Metrics/BlockLength
