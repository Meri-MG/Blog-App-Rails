require 'rails_helper'

# rubocop:disable Metrics/BlockLength

RSpec.feature 'Users', type: :system do
  describe 'Index Page' do
    let!(:users) do
      users = [
        User.create!(
          name: 'Meri2',
          id: 3,
          email: 'meri2@example.com',
          password: 'password',
          posts_counter: 6,
          confirmed_at: Time.now
        ),
        User.create!(
          name: 'Meri1',
          id: 2,
          email: 'meri1@example.com',
          password: 'password',
          posts_counter: 4,
          confirmed_at: Time.now
        )
      ]
      visit new_user_session_path
      fill_in 'user_email', with: 'meri2@example.com'
      fill_in 'user_password', with: 'password'
      click_button 'Log in'
      visit '/users/'
      users
    end

    it 'should show all the names of the user' do
      users.each do |user|
        expect(page).to have_content(user.name)
        expect(page).to have_content(user.posts_counter)
        page.should have_selector('img')
        click_link user.posts_counter
        expect(page).to have_current_path user_path(user.id)
        visit '/users'
      end
    end
  end
end

# rubocop:enable Metrics/BlockLength
