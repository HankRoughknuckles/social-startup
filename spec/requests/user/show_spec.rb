require "spec_helper"

describe "User Show Page" do
  let(:subject_user) { FactoryGirl.create(:user) }

  # page objects
  let(:show_page) { UserShowPage.new(subject_user) }
  let(:signup_page) { SignupPage.new }


  it 'should redirect to the signup page when not logged in' do
    show_page.visit_page_as nil 

    expect(page.title).to eq signup_page.title
  end
end
