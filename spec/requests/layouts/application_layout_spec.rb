require "spec_helper"

describe "The Application Layout" do
  let(:layout) { ApplicationLayoutPage.new }


  context 'when logged in' do
    let(:user) { FactoryGirl.create(:user) }

    before do
      login_as(user)
      visit root_path
    end

    it "should have a working sign out button" do
      layout.click_sign_out_button
      expect(layout).to have_sign_in_button
    end

    it "should have a profile button" do
      layout.click_profile_button
      expect(page).to have_title UserShowPage.new(user).title
    end
  end


  context 'when logged out' do
    before do
      logout
      visit root_path
    end

    it "Should have a sign in button" do
      layout.click_sign_in_button
      expect(page).to have_title NewSessionPage.new.title
    end

    it "Should have a sign up button"
  end
end
