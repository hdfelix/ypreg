require 'rails_helper'

feature 'User can visit the home page' do
  scenario 'and see upcoming events on the home page' do
    events = create_list(:event_with_registrations, 2)
    visit root_path

    expect(page).to have_content('Upcoming events')
    expect(page).to have_content(events.first.title)
    expect(page).to have_content(events.second.title)
  end

  scenario 'Can access sign in / sign up page' do
    visit root_path

    expect(page).to have_content('Sign in')
  end

  scenario 'can view sign in form' do
    visit new_user_session_path

    expect(page).to have_content('Enter your e-mail')
    expect(page).to have_content('Login')
    expect(page).to have_content('Sign up')
    expect(page).to have_content('Forgot your password?')
    expect(page).to have_content("Didn't receive confirmation instructions?")
  end

  scenario 'can view sign up form with all appropriate fields' do
    visit new_user_registration_path

    expect(page).to have_content('Sign up')
    expect(find_by_id('user_name').native.attributes['placeholder'].value).to eq 'Enter name'
    expect(find_by_id('user_gender').native.children[0].children.text).to eq 'Select gender'
    expect(find_by_id('user_age').native.children[0].children.text).to eq 'Select your age'
    expect(find_by_id('user_grade').native.children[0].children.text).to eq 'Select your grade'
    expect(find_by_id('user_locality_id').native.children[0].children.text).to eq 'Select locality'
    expect(find_by_id('user_email').native.attributes['placeholder'].value).to eq 'Enter email'
    expect(find_by_id('user_password').native.attributes['placeholder'].value)
      .to eq 'Enter password'
    expect(find_by_id('user_password_confirmation').native.attributes['placeholder'].value)
      .to eq 'Enter password confirmation'
  end
end
