require "spec_helper"

describe "Edit User Registration Page" do
  let(:user) { FactoryGirl.create(:user) }
  let(:edit_page) { EditUserPage.new user }

  before { edit_page.visit_page_as user }

  it 'should have a profile pic' do
    expect(edit_page).to have_a_profile_picture
  end
end
