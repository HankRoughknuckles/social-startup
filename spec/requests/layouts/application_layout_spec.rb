require "spec_helper"

describe "The Application Layout" do
  context 'when logged in' do
    let(:user) { FactoryGirl.create(:user) }
    let(:layout) { ApplicationLayoutPage.new }

    before do
      login_as(user)
      visit root_path
    end

    it "should have a working sign out button" do
      layout.click_sign_out_button
      expect(layout).to have_sign_in_button
    end

    it "should have a profile button"
  end


  context 'when logged out' do
    it "Should have a sign in button"
    it "Should have a sign up button"
  end
end
