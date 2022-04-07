require 'rails_helper'

RSpec.feature "Users", type: :system do
  describe 'Page form' do 
    before(:each) do
      visit new_user_session_path
    end

    it 'shows the login page content' do
      expect(page).to have_content('Log in')
    end

    it 'has email, password and login fields in the form' do
      expect(page).to have_field('Email')
      expect(page).to have_field('Password')
      expect(page).to have_button('Log in')
    end

    context "Failed attempts to login the user" do
      it 'doesnt have email and password fields filled out' do
          fill_in 'user_email', with: ''
          fill_in 'user_password', with: ''
          click_button 'Log in'
          expect(page).to have_content('Invalid Email or password')
      end

      it 'doesnt have password field filled out' do
        fill_in 'user_email', with: 'meri@test.com'
        fill_in 'user_password', with: ''
        click_button 'Log in'
        expect(page).to have_content('Invalid Email or password')
      end

      it 'doesnt have email and password fields filled out' do
        fill_in 'user_email', with: ''
        fill_in 'user_password', with: 'password'
        click_button 'Log in'
        expect(page).to have_content('Invalid Email or password')
      end
    end

    context "Successful attempt to login the user and should redirect to root page" do
      it 'has all the fields filled out' do
        user1 = User.create(
        name: 'Meri',
        id: 1,
        email: 'meri2@example.com',
        password: 'password',
        confirmed_at: Time.now
      )
        fill_in 'user_email', with: 'meri2@example.com'
        fill_in 'user_password', with: 'password'
        click_button 'Log in'
        expect(page).to have_current_path root_path
      end
    end
  end
end