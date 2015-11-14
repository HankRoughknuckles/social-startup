require "spec_helper"

describe "The Edit User Page" do
  let(:user) { FactoryGirl.create(:user) }
  let(:edit_page) { EditUserPage.new user }

  it "should redirect to the signup page when not logged in" do
    edit_page.visit_page_as nil

    expect(page)
      .to have_content "You need to sign in or sign up before continuing."
  end

  context 'when logged in as the user' do
    before { edit_page.visit_page_as user }


    it { expect(edit_page).to have_a_profile_picture_input }
  end
end
